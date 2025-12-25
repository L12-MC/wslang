import 'dart:io';
import 'dart:convert';
import 'package:crypto/crypto.dart';

const String VERSION = "1.2.1";

Map<String, dynamic> variables = {};
Map<String, Function> functions = {};
Map<String, dynamic> classes = {};
String? currentError;
dynamic returnValue;
bool hasReturned = false;
bool shouldBreak = false;

// Error reporting
int currentLineNum = 0;
String currentLineText = "";
String currentFile = "";

void reportError(String message,
    {String? line, int? lineNum, String? suggestion}) {
  print("");
  print("━" * 60);
  print("ERROR");
  print("━" * 60);

  if (currentFile.isNotEmpty) {
    print("File: $currentFile");
  }

  // Use provided lineNum or fall back to currentLineNum
  int displayLineNum = lineNum ?? currentLineNum;
  if (displayLineNum > 0) {
    print("Line: $displayLineNum");
  }

  print("");
  print("$message");

  // Use provided line or fall back to currentLineText
  String displayLine = line ?? currentLineText;
  if (displayLine.trim().isNotEmpty) {
    print("");
    print("Problematic code:");
    print("  │ $displayLine");
    print("  └─" + "─" * displayLine.length);
  }

  if (suggestion != null) {
    print("");
    print("Suggestion:");
    print("  $suggestion");
  }

  print("━" * 60);
  print("");

  currentError = message;
}

// Package manager
class PackageManager {
  static const String packagesDir = 'ws_packages';
  static const String packagesFile = 'ws_packages.json';

  static Map<String, dynamic> loadInstalledPackages() {
    try {
      final file = File(packagesFile);
      if (file.existsSync()) {
        String content = file.readAsStringSync();
        return jsonDecode(content);
      }
    } catch (e) {
      // Ignore errors
    }
    return {};
  }

  static void saveInstalledPackages(Map<String, dynamic> packages) {
    try {
      final file = File(packagesFile);
      file.writeAsStringSync(jsonEncode(packages));
    } catch (e) {
      print("Error saving package metadata: $e");
    }
  }

  static Future<bool> installPackage(String url, String? name) async {
    try {
      // Extract package name from URL if not provided
      if (name == null || name.isEmpty) {
        name = url.split('/').last.replaceAll('.git', '');
      }

      print("Installing package: $name");
      print("From: $url");

      // Create packages directory if it doesn't exist
      final dir = Directory(packagesDir);
      if (!dir.existsSync()) {
        dir.createSync();
      }

      final packagePath = '$packagesDir/$name';
      final packageDir = Directory(packagePath);

      // Remove existing package if it exists
      if (packageDir.existsSync()) {
        print("Removing existing version...");
        packageDir.deleteSync(recursive: true);
      }

      // Clone the repository
      print("Cloning repository...");
      var result = await Process.run('git', ['clone', url, packagePath]);

      if (result.exitCode != 0) {
        print("Error cloning repository:");
        print(result.stderr);
        return false;
      }

      print("Package installed successfully!");

      // Save package info
      var packages = loadInstalledPackages();
      packages[name] = {
        'url': url,
        'path': packagePath,
        'installed': DateTime.now().toIso8601String()
      };
      saveInstalledPackages(packages);

      return true;
    } catch (e) {
      print("Error installing package: $e");
      return false;
    }
  }

  static void listPackages() {
    var packages = loadInstalledPackages();

    if (packages.isEmpty) {
      print("No packages installed.");
      print(
          "Use pkg.install(\"git-url\", \"package-name\") to install packages.");
      return;
    }

    print("Installed packages:");
    print("==================");
    packages.forEach((name, info) {
      print("\n$name");
      print("  URL: ${info['url']}");
      print("  Path: ${info['path']}");
      print("  Installed: ${info['installed']}");
    });
  }

  static bool removePackage(String name) {
    try {
      var packages = loadInstalledPackages();

      if (!packages.containsKey(name)) {
        print("Package not found: $name");
        return false;
      }

      final packagePath = packages[name]['path'];
      final packageDir = Directory(packagePath);

      if (packageDir.existsSync()) {
        packageDir.deleteSync(recursive: true);
        print("Package removed: $name");
      }

      packages.remove(name);
      saveInstalledPackages(packages);

      return true;
    } catch (e) {
      print("Error removing package: $e");
      return false;
    }
  }

  static String? resolvePackagePath(String filename) {
    // First check if file exists as-is
    if (File(filename).existsSync()) {
      return filename;
    }

    // Check in packages directory
    var packages = loadInstalledPackages();
    for (var entry in packages.entries) {
      String packagePath = entry.value['path'];
      String packageName = entry.key;

      // Check if filename is package_name or package_name/file
      String fileToImport = filename;
      if (filename == packageName) {
        // Import whole package - try to import all .wsx files from src/
        String srcPath = '$packagePath/src';
        if (Directory(srcPath).existsSync()) {
          // For now, return the src directory path
          // The import handler should then import all .wsx files
          return srcPath;
        }
      } else if (filename.startsWith('$packageName/')) {
        // Specific file from package
        fileToImport = filename.substring(packageName.length + 1);
      }

      // Try package_name/src/filename.wsx (new structure)
      String srcPath = '$packagePath/src/$fileToImport';
      if (!fileToImport.endsWith('.wsx') && !fileToImport.endsWith('.ws')) {
        srcPath += '.wsx';
      }
      if (File(srcPath).existsSync()) {
        return srcPath;
      }

      // Try package_name/filename (old structure)
      String fullPath = '$packagePath/$fileToImport';
      if (File(fullPath).existsSync()) {
        return fullPath;
      }

      // Try with .ws extension
      if (!fileToImport.endsWith('.ws') &&
          !fileToImport.endsWith('.wsx') &&
          !fileToImport.endsWith('.repl')) {
        fullPath = '$packagePath/$fileToImport.ws';
        if (File(fullPath).existsSync()) {
          return fullPath;
        }
      }
    }

    return null;
  }
}

// GUI library for visual window rendering
class GuiWindow {
  int width = 800;
  int height = 600;
  String title = "Well.. Simple GUI";
  List<Map<String, dynamic>> widgets = [];
  List<String> styles = [];
  bool isVisible = false;
  String? htmlFilePath;
  HttpServer? server;
  int serverPort = 8765;

  void createWindow(int w, int h, String t) {
    width = w;
    height = h;
    title = t;
    widgets.clear();
    print("GUI Window configured: ${width}x$height - $title");
  }

  void addButton(double x, double y, double w, double h, String text) {
    widgets.add({
      'type': 'button',
      'x': x,
      'y': y,
      'width': w,
      'height': h,
      'text': text
    });
  }

  void addStyle(String css) {
    if (css.trim().isEmpty) return;
    List<String> lines = css.split('\n');
    for (var i = 0; i < lines.length; i++) {
      lines[i] = lines[i].trim();
    }
    for (var i = 0; i < lines.length; i++) {
      styles.add(lines[i]);
    }
  }

  void addLabel(double x, double y, String text) {
    widgets.add({'type': 'label', 'x': x, 'y': y, 'text': text});
  }

  void addCenterLabel(double y, String text) {
    widgets.add({'type': 'labelcenter', 'x': 0.0, 'y': y, 'text': text});
  }

  void addTitle(double x, double y, String text) {
    widgets.add({'type': 'title', 'x': 0.0, 'y': 0.0, 'text': text});
  }

  void addInput(double x, double y, double w, double h) {
    widgets.add({'type': 'input', 'x': x, 'y': y, 'width': w, 'height': h});
  }

  String generateHTML() {
    StringBuffer html = StringBuffer();
    html.writeln('<!DOCTYPE html>');
    html.writeln('<html>');
    html.writeln('<head>');
    html.writeln('  <meta charset="UTF-8">');
    html.writeln('  <title>$title</title>');
    html.writeln('  <style>');
    html.writeln('    body {');
    html.writeln('      margin: 0;');
    html.writeln('      padding: 0;');
    html.writeln('      font-family: Arial, sans-serif;');
    html.writeln('      overflow: hidden;');
    html.writeln('    }');
    html.writeln('    #gui-container {');
    html.writeln('      position: relative;');
    html.writeln('      width: ${width}px;');
    html.writeln('      height: ${height}px;');
    html.writeln('      background: #f0f0f0;');
    html.writeln('      border: 1px solid #ccc;');
    html.writeln('      margin: 20px auto;');
    html.writeln('      border-radius: 12px;');
    html.writeln('      box-shadow: 0 2px 10px rgba(0,0,0,0.1);');
    html.writeln('    }');
    html.writeln('    .widget {');
    html.writeln('      position: absolute;');
    html.writeln('      box-sizing: border-box;');
    html.writeln('    }');
    html.writeln('    .button {');
    html.writeln('      background: #2196F3;');
    html.writeln('      color: white;');
    html.writeln('      border: solid 2px #249AF9;');
    html.writeln('      border-radius: 8px;');
    html.writeln('      font-size: 14px;');
    html.writeln('      cursor: pointer;');
    html.writeln('      display: flex;');
    html.writeln('      align-items: center;');
    html.writeln('      justify-content: center;');
    html.writeln('      transition: all 0.3s ease;');
    html.writeln('    }');
    html.writeln('    .button:hover {');
    html.writeln('      background: #1884E4;');
    html.writeln('      border: solid 2px #299FFF;');
    html.writeln('      transform: scale(1.03);');
    html.writeln('    }');
    html.writeln('    .label {');
    html.writeln('      color: #333;');
    html.writeln('      font-size: 14px;');
    html.writeln('      display: flex;');
    html.writeln('      align-items: center;');
    html.writeln('    }');
    html.writeln('    .labelcenter {');
    html.writeln('      color: #333;');
    html.writeln('      font-size: 14px; position: relative; display: block; width: 100%; text-align: center;');
    html.writeln('      align-items: center;');
    html.writeln('    }');
    html.writeln('    .input {');
    html.writeln('      border: 1px solid #ccc;');
    html.writeln('      border-radius: 4px;');
    html.writeln('      padding: 8px;');
    html.writeln('      font-size: 14px;');
    html.writeln('    }');
    html.writeln('    .input:focus {');
    html.writeln('      outline: none;');
    html.writeln('      border-color: #2196F3;');
    html.writeln('      transition: all 0.5s ease;');
    html.writeln('    }');
    html.writeln('    #title-bar {');
    html.writeln('      background: #2196F3;');
    html.writeln('      color: white;');
    html.writeln('      padding: 12px;');
    html.writeln('      font-weight: bold;');
    html.writeln('      text-align: center;');
    html.writeln('      margin-bottom: 20px;');
    html.writeln('      border-bottom-left-radius: 8px;');
    html.writeln('      border-bottom-right-radius: 8px;');
    html.writeln('    }');
    html.writeln('    h1 {font-size: 24px; position: absolute; width: 100%; text-align: center; margin: 25px 0; color: #222;}');
    html.writeln('  </style>');
    if (styles.isNotEmpty) {
      html.writeln('  <style>');
      for (var style in styles) {
        html.writeln(style);
      }
      html.writeln('  </style>');
    }
    html.writeln('</head>');
    html.writeln('<body>');
    html.writeln('  <div id="title-bar">$title</div>');
    html.writeln('  <div id="gui-container">');

    for (var widget in widgets) {
      String type = widget['type'];
      double x = widget['x'];
      double y = widget['y'];

      if (type == 'button') {
        double w = widget['width'];
        double h = widget['height'];
        String text = widget['text'];
        html.writeln(
            '    <button class="widget button" style="left: ${x}px; top: ${y}px; width: ${w}px; height: ${h}px;">$text</button>');
      } else if (type == 'labelcenter') {
        String text = widget['text'];
        html.writeln(
            '    <div class="widget labelcenter" style="top: ${y}px">$text</div>');
      } else if (type == 'label') {
        String text = widget['text'];
        html.writeln(
            '    <div class="widget label" style="left: ${x}px; top: ${y}px;">$text</div>');
      } else if (type == 'title') {
        String text = widget['text'];
        html.writeln(
            '    <h1>$text</h1>');
      } else if (type == 'input') {
        double w = widget['width'];
        double h = widget['height'];
        html.writeln(
            '    <input class="widget input" type="text" style="left: ${x}px; top: ${y}px; width: ${w}px; height: ${h}px;" />');
      }
    }



    html.writeln('  </div>');
    html.writeln('</body>');
    html.writeln('</html>');
    return html.toString();
  }

  Future<void> show() async {
    isVisible = true;

    // Generate HTML content
    String htmlContent = generateHTML();

    try {
      // Start a simple HTTP server
      server = await HttpServer.bind('127.0.0.1', serverPort);
      print("GUI Window starting on http://127.0.0.1:$serverPort");

      // Handle requests
      server!.listen((HttpRequest request) {
        request.response
          ..headers.contentType = ContentType.html
          ..write(htmlContent)
          ..close();
      });

      // Open in default browser
      String url = 'http://127.0.0.1:$serverPort';
      if (Platform.isWindows) {
        Process.run('cmd', ['/c', 'start', url]);
      } else if (Platform.isMacOS) {
        Process.run('open', [url]);
      } else if (Platform.isLinux) {
        Process.run('xdg-open', [url]);
      }

      print("GUI Window opened in browser");
    } catch (e) {
      print("Error creating GUI window: $e");
      // Fallback to file-based approach
      await _showViaFile();
    }
  }

  Future<void> _showViaFile() async {
    // Fallback: create HTML file and open it
    String htmlContent = generateHTML();
    htmlFilePath = 'ws_gui_${DateTime.now().millisecondsSinceEpoch}.html';

    File htmlFile = File(htmlFilePath!);
    await htmlFile.writeAsString(htmlContent);

    print("GUI Window created: $htmlFilePath");

    // Open in default browser
    String fullPath = htmlFile.absolute.path;
    if (Platform.isWindows) {
      Process.run('cmd', ['/c', 'start', fullPath]);
    } else if (Platform.isMacOS) {
      Process.run('open', [fullPath]);
    } else if (Platform.isLinux) {
      Process.run('xdg-open', [fullPath]);
    }

    print("GUI Window opened in browser");
  }

  Future<void> close() async {
    isVisible = false;

    // Close HTTP server if running
    if (server != null) {
      await server!.close();
      server = null;
      print("GUI Window server closed");
    }

    // Clean up HTML file if it was created
    if (htmlFilePath != null) {
      try {
        File htmlFile = File(htmlFilePath!);
        if (await htmlFile.exists()) {
          await htmlFile.delete();
          print("GUI Window file cleaned up");
        }
      } catch (e) {
        // Ignore cleanup errors
      }
      htmlFilePath = null;
    }

    print("GUI Window closed");
  }
}

GuiWindow guiWindow = GuiWindow();

// Graphics canvas
class Canvas {
  List<Map<String, dynamic>> shapes = [];
  int width = 800;
  int height = 600;

  void clear() {
    shapes.clear();
  }

  void drawTriangle(double x1, double y1, double x2, double y2, double x3,
      double y3, String color) {
    shapes.add({
      'type': 'triangle',
      'points': [x1, y1, x2, y2, x3, y3],
      'color': color
    });
  }

  void drawCircle(double x, double y, double radius, String color) {
    shapes.add(
        {'type': 'circle', 'x': x, 'y': y, 'radius': radius, 'color': color});
  }

  void drawRectangle(
      double x, double y, double width, double height, String color) {
    shapes.add({
      'type': 'rectangle',
      'x': x,
      'y': y,
      'width': width,
      'height': height,
      'color': color
    });
  }

  void drawPolygon(List<double> points, String color) {
    shapes.add({'type': 'polygon', 'points': points, 'color': color});
  }

  void drawLine(double x1, double y1, double x2, double y2, String color) {
    shapes.add({
      'type': 'line',
      'x1': x1,
      'y1': y1,
      'x2': x2,
      'y2': y2,
      'color': color
    });
  }

  void render() {
    print("\n=== Canvas Render (${width}x$height) ===");
    print("Total shapes: ${shapes.length}");
    for (var i = 0; i < shapes.length; i++) {
      var shape = shapes[i];
      print("${i + 1}. ${shape['type']} - color: ${shape['color']}");
    }
    print("=== End Render ===\n");
  }

  void exportSVG(String filename) {
    var file = File(filename);
    var svg = StringBuffer();
    svg.writeln(
        '<svg width="$width" height="$height" xmlns="http://www.w3.org/2000/svg">');

    for (var shape in shapes) {
      switch (shape['type']) {
        case 'circle':
          svg.writeln(
              '  <circle cx="${shape['x']}" cy="${shape['y']}" r="${shape['radius']}" fill="${shape['color']}" />');
          break;
        case 'rectangle':
          svg.writeln(
              '  <rect x="${shape['x']}" y="${shape['y']}" width="${shape['width']}" height="${shape['height']}" fill="${shape['color']}" />');
          break;
        case 'triangle':
          var pts = shape['points'];
          svg.writeln(
              '  <polygon points="${pts[0]},${pts[1]} ${pts[2]},${pts[3]} ${pts[4]},${pts[5]}" fill="${shape['color']}" />');
          break;
        case 'polygon':
          var pts = shape['points'] as List;
          var pointStr = '';
          for (var i = 0; i < pts.length; i += 2) {
            pointStr += '${pts[i]},${pts[i + 1]} ';
          }
          svg.writeln(
              '  <polygon points="$pointStr" fill="${shape['color']}" />');
          break;
        case 'line':
          svg.writeln(
              '  <line x1="${shape['x1']}" y1="${shape['y1']}" x2="${shape['x2']}" y2="${shape['y2']}" stroke="${shape['color']}" stroke-width="2" />');
          break;
      }
    }

    svg.writeln('</svg>');
    file.writeAsStringSync(svg.toString());
  }
}

Canvas canvas = Canvas();

String calculate(String num1, String num2, String op) {
  if (!['+', '-', '*', '/', '%'].contains(op)) {
    reportError("Invalid operator: $op",
        suggestion: "Valid operators are: +, -, *, /, %");
    return num2;
  }
  if (op == '/' && double.tryParse(num2) == 0) {
    reportError("Division by zero",
        suggestion: "Cannot divide by zero. Check your divisor value.");
    return num2;
  }
  double result;
  if (op == "+") {
    result = double.parse(num1) + double.parse(num2);
  } else if (op == "-") {
    result = double.parse(num1) - double.parse(num2);
  } else if (op == "*") {
    result = double.parse(num1) * double.parse(num2);
  } else if (op == "/") {
    result = double.parse(num1) / double.parse(num2);
  } else {
    result = double.parse(num1) % double.parse(num2);
  }
  return result.toString();
}

dynamic parseValue(String token) {
  token = token.trim();

  // String literals
  if (token.startsWith('"') && token.endsWith('"')) {
    return token.substring(1, token.length - 1);
  }
  if (token.startsWith("'") && token.endsWith("'")) {
    return token.substring(1, token.length - 1);
  }

  // List literals
  if (token.startsWith('[') && token.endsWith(']')) {
    return parseList(token);
  }

  // Booleans
  if (token == 'true') return true;
  if (token == 'false') return false;

  // Object property access (obj.property)
  if (token.contains('.') && !token.contains('(')) {
    int dotIdx = token.indexOf('.');
    String objName = token.substring(0, dotIdx).trim();
    String propName = token.substring(dotIdx + 1).trim();

    if (variables.containsKey(objName) && variables[objName] is Map) {
      Map<String, dynamic> obj = variables[objName];
      if (obj.containsKey(propName)) {
        return obj[propName];
      }
    }
  }

  // Variables
  if (variables.containsKey(token)) {
    return variables[token];
  }

  // Numbers
  return double.parse(token);
}

List<dynamic> parseList(String listStr) {
  listStr = listStr.substring(1, listStr.length - 1).trim();
  if (listStr.isEmpty) return [];

  List<dynamic> result = [];
  List<String> parts = [];
  String current = '';
  int depth = 0;
  bool inString = false;
  String stringChar = '';

  for (var i = 0; i < listStr.length; i++) {
    var char = listStr[i];

    if ((char == '"' || char == "'") && (i == 0 || listStr[i - 1] != '\\')) {
      if (!inString) {
        inString = true;
        stringChar = char;
      } else if (char == stringChar) {
        inString = false;
      }
      current += char;
    } else if (inString) {
      current += char;
    } else if (char == '[') {
      depth++;
      current += char;
    } else if (char == ']') {
      depth--;
      current += char;
    } else if (char == ',' && depth == 0) {
      parts.add(current.trim());
      current = '';
    } else {
      current += char;
    }
  }

  if (current.isNotEmpty) {
    parts.add(current.trim());
  }

  for (var part in parts) {
    try {
      result.add(parseValue(part));
    } catch (e) {
      result.add(part);
    }
  }

  return result;
}

// Evaluate string methods like .length() and .letter(index)
dynamic evaluateStringMethod(String expression) {
  RegExp lengthPattern = RegExp(r'(.+)\.length\(\)');
  RegExp letterPattern = RegExp(r'(.+)\.letter\((.+)\)');

  Match? lengthMatch = lengthPattern.firstMatch(expression);
  if (lengthMatch != null) {
    String target = lengthMatch.group(1)!.trim();
    String strValue;

    if ((target.startsWith('"') && target.endsWith('"')) ||
        (target.startsWith("'") && target.endsWith("'"))) {
      strValue = target.substring(1, target.length - 1);
    } else if (variables.containsKey(target)) {
      strValue = variables[target].toString();
    } else {
      throw Exception("Variable '$target' not defined");
    }

    return strValue.length;
  }

  Match? letterMatch = letterPattern.firstMatch(expression);
  if (letterMatch != null) {
    String target = letterMatch.group(1)!.trim();
    String indexStr = letterMatch.group(2)!.trim();
    String strValue;

    if ((target.startsWith('"') && target.endsWith('"')) ||
        (target.startsWith("'") && target.endsWith("'"))) {
      strValue = target.substring(1, target.length - 1);
    } else if (variables.containsKey(target)) {
      strValue = variables[target].toString();
    } else {
      throw Exception("Variable '$target' not defined");
    }

    // Parse index - could be a number or a variable
    int index;
    try {
      index = int.parse(indexStr);
    } catch (_) {
      // Try as a variable
      if (variables.containsKey(indexStr)) {
        dynamic varValue = variables[indexStr];
        index = (varValue is num)
            ? varValue.toInt()
            : int.parse(varValue.toString());
      } else {
        throw Exception("Variable '$indexStr' not defined");
      }
    }

    if (index >= 0 && index < strValue.length) {
      return strValue[index];
    } else {
      throw Exception("Index $index out of range");
    }
  }

  throw Exception("Invalid string method");
}

// Find the next function call in the expression using proper parenthesis matching
Map<String, dynamic>? findNextFunctionCall(String expression) {
  RegExp funcNamePattern = RegExp(r'\w+\(');
  Match? nameMatch = funcNamePattern.firstMatch(expression);

  if (nameMatch == null) return null;

  int startPos = nameMatch.start;
  int openParenPos = nameMatch.end - 1;
  String funcName = expression.substring(startPos, openParenPos);

  // Count parentheses to find the matching closing paren
  int depth = 1;
  int i = openParenPos + 1;

  while (i < expression.length && depth > 0) {
    if (expression[i] == '(') {
      depth++;
    } else if (expression[i] == ')') {
      depth--;
    }
    i++;
  }

  if (depth != 0) return null; // Unmatched parentheses

  int closeParenPos = i - 1;
  String args = expression.substring(openParenPos + 1, closeParenPos);
  String fullMatch = expression.substring(startPos, closeParenPos + 1);

  return {
    'funcName': funcName,
    'args': args,
    'fullMatch': fullMatch,
    'startPos': startPos,
  };
}

String resolveThisReferences(String expression) {
  // Replace this.property with the actual value from the 'this' object
  if (!expression.contains('this.')) return expression;

  if (!variables.containsKey('this') || variables['this'] is! Map) {
    return expression;
  }

  Map<String, dynamic> thisObj = variables['this'];

  // Find all this.property references
  RegExp thisPattern = RegExp(r'this\.(\w+)');

  String result = expression;
  for (var match in thisPattern.allMatches(expression)) {
    String propName = match.group(1)!;
    if (thisObj.containsKey(propName)) {
      String replacement = thisObj[propName].toString();
      result = result.replaceAll('this.$propName', replacement);
    }
  }

  return result;
}

String preprocessExpression(String expression) {
  // First, replace this.property with actual values
  expression = resolveThisReferences(expression);

  // Replace function calls with their return values, starting from innermost
  int maxIterations = 20; // Prevent infinite loops
  int iterations = 0;

  while (iterations < maxIterations) {
    iterations++;
    Map<String, dynamic>? match = findNextFunctionCall(expression);

    if (match == null) break;

    String funcName = match['funcName'];
    String args = match['args'];
    String fullMatch = match['fullMatch'];

    if (functions.containsKey(funcName)) {
      try {
        // Recursively preprocess arguments first
        String preprocessedArgs = preprocessExpression(args);

        // Split arguments by comma, but respect parentheses
        List<String> argStrings = [];
        int depth = 0;
        StringBuffer current = StringBuffer();

        for (int i = 0; i < preprocessedArgs.length; i++) {
          String char = preprocessedArgs[i];
          if (char == '(') {
            depth++;
            current.write(char);
          } else if (char == ')') {
            depth--;
            current.write(char);
          } else if (char == ',' && depth == 0) {
            argStrings.add(current.toString().trim());
            current.clear();
          } else {
            current.write(char);
          }
        }
        if (current.isNotEmpty) {
          argStrings.add(current.toString().trim());
        }

        // Parse argument values
        List<dynamic> argList = argStrings.map((e) {
          try {
            return double.parse(e);
          } catch (_) {
            try {
              return parseValue(e);
            } catch (_) {
              // Try to evaluate as an expression
              try {
                List<String> tokens = tokenizeExpression(e);
                return evaluateExpression(tokens);
              } catch (_) {
                return e;
              }
            }
          }
        }).toList();

        dynamic result = functions[funcName]!(argList);
        if (result != null) {
          expression = expression.replaceFirst(fullMatch, result.toString());
        } else {
          // Remove this function call even if it returns null
          expression = expression.replaceFirst(fullMatch, '0');
        }
      } catch (e) {
        // If error, stop processing
        break;
      }
    } else {
      // Not a user function, replace with placeholder to avoid matching again
      expression = expression.replaceFirst(fullMatch, '_FUNC_${fullMatch}_');
    }
  }

  // Restore non-user function calls
  expression = expression.replaceAll(RegExp(r'_FUNC_(.+?)_'), r'$1');

  return expression;
}

double evaluateExpression(List<String> tokens) {
  for (int i = 0; i < tokens.length; i++) {
    if (!['(', ')', '+', '-', '*', '/', '%'].contains(tokens[i])) {
      try {
        double.parse(tokens[i]);
      } catch (e) {
        if (variables.containsKey(tokens[i])) {
          tokens[i] = variables[tokens[i]].toString();
        } else {
          throw Exception("Undefined variable: ${tokens[i]}");
        }
      }
    }
  }

  while (tokens.contains('(')) {
    int openIdx = tokens.lastIndexOf('(');
    int closeIdx = openIdx;
    for (int i = openIdx; i < tokens.length; i++) {
      if (tokens[i] == ')') {
        closeIdx = i;
        break;
      }
    }
    List<String> subExpr = tokens.sublist(openIdx + 1, closeIdx);
    double subResult = evaluateExpression(subExpr);
    tokens.replaceRange(openIdx, closeIdx + 1, [subResult.toString()]);
  }

  for (int i = 1; i < tokens.length; i += 2) {
    if (['*', '/', '%'].contains(tokens[i])) {
      String result = calculate(tokens[i - 1], tokens[i + 1], tokens[i]);
      tokens.replaceRange(i - 1, i + 2, [result]);
      i -= 2;
    }
  }

  for (int i = 1; i < tokens.length; i += 2) {
    if (['+', '-'].contains(tokens[i])) {
      String result = calculate(tokens[i - 1], tokens[i + 1], tokens[i]);
      tokens.replaceRange(i - 1, i + 2, [result]);
      i -= 2;
    }
  }

  return double.parse(tokens[0]);
}

bool evaluateCondition(String condition) {
  condition = condition.trim();

  // Handle comparison operators
  for (var op in ['<=', '>=', '==', '!=', '<', '>']) {
    if (condition.contains(op)) {
      List<String> parts = condition.split(op);
      if (parts.length == 2) {
        dynamic left = parseValue(parts[0].trim());
        dynamic right = parseValue(parts[1].trim());

        switch (op) {
          case '<':
            return (left as num) < (right as num);
          case '>':
            return (left as num) > (right as num);
          case '<=':
            return (left as num) <= (right as num);
          case '>=':
            return (left as num) >= (right as num);
          case '==':
            return left == right;
          case '!=':
            return left != right;
        }
      }
    }
  }

  // Handle boolean variables
  try {
    return parseValue(condition) as bool;
  } catch (e) {
    return false;
  }
}

void executeBlock(List<String> commands) {
  int i = 0;
  while (i < commands.length && !hasReturned && !shouldBreak) {
    String cmd = commands[i];

    // Handle multi-line blocks (while, if, for, try, etc.)
    if (cmd.trim().startsWith('while ') ||
        cmd.trim().startsWith('if ') ||
        cmd.trim().startsWith('for ') ||
        cmd.trim().startsWith('try')) {
      List<String> block = [cmd.trim()];
      i++;
      int depth = 1;

      while (i < commands.length && depth > 0) {
        String blockLine = commands[i].trim();
        if (blockLine == 'end') {
          depth--;
          if (depth == 0) {
            processMultiLineCommand(block);
            break;
          }
        }
        if (blockLine.startsWith('while ') ||
            blockLine.startsWith('if ') ||
            blockLine.startsWith('for ') ||
            blockLine.startsWith('try')) {
          depth++;
        }
        block.add(blockLine);
        i++;
      }
    } else {
      processCommand(cmd);
    }
    i++;
  }
}

void processCommand(String cmd) {
  cmd = cmd.trim();
  if (cmd.isEmpty) return;

  // Handle return statement
  if (cmd.startsWith('return')) {
    hasReturned = true;
    if (cmd.length > 6) {
      String expression = cmd.substring(6).trim();
      try {
        // Preprocess to handle nested function calls
        expression = preprocessExpression(expression);

        // Try to evaluate as expression
        List<String> tokens = tokenizeExpression(expression);
        returnValue = evaluateExpression(tokens);
      } catch (e) {
        // Try as a value
        try {
          returnValue = parseValue(expression);
        } catch (e2) {
          returnValue = null;
        }
      }
    } else {
      returnValue = null;
    }
    return;
  }

  // Handle break statement
  if (cmd == 'break') {
    shouldBreak = true;
    return;
  }

  // Version command
  if (cmd == 'version' || cmd == 'version()') {
    print("Well.. Simple v$VERSION");
    return;
  }

  // Package manager commands
  if (cmd.startsWith('pkg.install(') && cmd.endsWith(')')) {
    String args = cmd.substring(12, cmd.length - 1).trim();
    List<String> parts = splitArgs(args);

    if (parts.isEmpty || parts.length > 2) {
      print(
          "Usage: pkg.install(\"git-url\") or pkg.install(\"git-url\", \"package-name\")");
      return;
    }

    String url = parseValue(parts[0]).toString();
    String? name;
    if (parts.length == 2) {
      name = parseValue(parts[1]).toString();
    }

    // Run async install
    PackageManager.installPackage(url, name).then((success) {
      if (!success) {
        print(
            "Installation failed. Make sure git is installed and the URL is correct.");
      }
    });
    return;
  }

  if (cmd == 'pkg.list' || cmd == 'pkg.list()') {
    PackageManager.listPackages();
    return;
  }

  if (cmd.startsWith('pkg.remove(') && cmd.endsWith(')')) {
    String name = cmd.substring(11, cmd.length - 1).trim();
    name = parseValue(name).toString();
    PackageManager.removePackage(name);
    return;
  }

  // Handle built-in functions
  if (cmd.startsWith('print(') && cmd.endsWith(')')) {
    String content = cmd.substring(6, cmd.length - 1).trim();

    // Handle string concatenation with + (check for quotes or input() calls)
    if (content.contains('+') &&
        (content.contains('"') ||
            content.contains("'") ||
            content.contains('input('))) {
      var result = evaluateStringExpression(content);
      if (result != null) {
        print(result);
        return;
      }
    }

    // Handle object property access
    if (content.contains('.') && !content.contains('(')) {
      try {
        dynamic value = parseValue(content);
        print(value);
        return;
      } catch (e) {
        // Fall through to other handlers
      }
    }

    // Handle list indexing
    if (content.contains('[') && content.contains(']')) {
      var value = evaluateListAccess(content);
      if (value != null) {
        print(value);
        return;
      }
    }

    try {
      dynamic value = parseValue(content);
      if (value is List) {
        print(value);
      } else {
        print(value);
      }
    } catch (e) {
      // Try string methods
      try {
        dynamic result = evaluateStringMethod(content);
        print(result);
      } catch (e2) {
        // Try to evaluate as an expression (e.g., i * i, x + y, etc.)
        try {
          String preprocessed = preprocessExpression(content);
          List<String> tokens = tokenizeExpression(preprocessed);
          double result = evaluateExpression(tokens);
          print(result);
        } catch (e3) {
          if (variables.containsKey(content)) {
            print(variables[content]);
          } else {
            print("Error: Invalid print argument.");
          }
        }
      }
    }
    return;
  }

  // Input function - read user input
  if (cmd.startsWith('input(') && cmd.endsWith(')')) {
    String content = cmd.substring(6, cmd.length - 1).trim();

    // Check if it's an assignment
    if (cmd.contains('=') && !cmd.contains('==')) {
      // This is handled by the assignment section below
      // Fall through to assignment handling
    } else {
      // Direct call - prompt and return input (don't print)
      if (content.isNotEmpty) {
        try {
          String prompt = parseValue(content).toString();
          stdout.write(prompt);
        } catch (e) {
          // Just use the content as-is
          stdout.write(content);
        }
      }
      stdin.readLineSync();
      // Return value instead of printing
      return;
    }
  }

  // String concatenation function
  if (cmd.startsWith('concat(') && cmd.endsWith(')')) {
    String args = cmd.substring(7, cmd.length - 1);
    List<String> parts = args.split(',').map((e) => e.trim()).toList();
    String result = '';
    for (var part in parts) {
      try {
        dynamic val = parseValue(part);
        result += val.toString();
      } catch (e) {
        result += part;
      }
    }
    print(result);
    return;
  }

  // String split function - can be used standalone or in assignment
  if (cmd.contains('split(')) {
    // Check if it's an assignment
    if (cmd.contains('=') && !cmd.contains('==')) {
      int eqIdx = cmd.indexOf('=');
      String varName = cmd.substring(0, eqIdx).trim();
      String expression = cmd.substring(eqIdx + 1).trim();

      if (expression.startsWith('split(') && expression.endsWith(')')) {
        String args = expression.substring(6, expression.length - 1);
        List<String> parts = splitArgs(args);
        if (parts.length == 2) {
          dynamic str = parseValue(parts[0]);
          dynamic delimiter = parseValue(parts[1]);
          var result = str.toString().split(delimiter.toString());
          variables[varName] = result;
        }
        return;
      }
    } else if (cmd.startsWith('split(') && cmd.endsWith(')')) {
      String args = cmd.substring(6, cmd.length - 1);
      List<String> parts = splitArgs(args);
      if (parts.length == 2) {
        dynamic str = parseValue(parts[0]);
        dynamic delimiter = parseValue(parts[1]);
        var result = str.toString().split(delimiter.toString());
        print(result);
      }
      return;
    }
  }

  // List append function
  if (cmd.startsWith('append(') && cmd.endsWith(')')) {
    String args = cmd.substring(7, cmd.length - 1);
    List<String> parts = splitArgs(args);
    if (parts.length == 2) {
      String listName = parts[0].trim();
      if (variables.containsKey(listName) && variables[listName] is List) {
        dynamic value = parseValue(parts[1]);
        (variables[listName] as List).add(value);
      }
    }
    return;
  }

  // Length function - can be used standalone or in assignment
  if (cmd.contains('length(')) {
    // Check if it's an assignment
    if (cmd.contains('=') && !cmd.contains('==')) {
      int eqIdx = cmd.indexOf('=');
      String varName = cmd.substring(0, eqIdx).trim();
      String expression = cmd.substring(eqIdx + 1).trim();

      if (expression.startsWith('length(') && expression.endsWith(')')) {
        String arg = expression.substring(7, expression.length - 1).trim();
        dynamic value = parseValue(arg);
        if (value is List) {
          variables[varName] = value.length.toDouble();
        } else if (value is String) {
          variables[varName] = value.length.toDouble();
        }
        return;
      }
    } else if (cmd.startsWith('length(') && cmd.endsWith(')')) {
      String arg = cmd.substring(7, cmd.length - 1).trim();
      dynamic value = parseValue(arg);
      if (value is List) {
        print(value.length.toDouble());
      } else if (value is String) {
        print(value.length.toDouble());
      }
      return;
    }
  }

  // File I/O operations
  if (cmd.startsWith('readFile(') && cmd.endsWith(')')) {
    // Check if it's an assignment
    if (cmd.contains('=') && !cmd.contains('==')) {
      // This is handled by the assignment section below
      // Fall through to assignment handling
    } else {
      // Direct call - return content without printing
      String filename = cmd.substring(9, cmd.length - 1).trim();
      filename = parseValue(filename).toString();
      try {
        File file = File(filename);
        file.readAsStringSync();
        // Don't print, just return (value is lost but at least doesn't print)
      } catch (e) {
        currentError = "Error reading file: $e";
        print(currentError);
      }
      return;
    }
  }

  if (cmd.startsWith('writeFile(') && cmd.endsWith(')')) {
    String args = cmd.substring(10, cmd.length - 1);
    List<String> parts = splitArgs(args);
    if (parts.length == 2) {
      String filename = parseValue(parts[0]).toString();
      String content = parseValue(parts[1]).toString();
      try {
        File file = File(filename);
        file.writeAsStringSync(content);
        print("File written: $filename");
      } catch (e) {
        currentError = "Error writing file: $e";
        print(currentError);
      }
    }
    return;
  }

  // JSON operations
  if (cmd.startsWith('json.parse(') && cmd.endsWith(')')) {
    String jsonStr = cmd.substring(11, cmd.length - 1).trim();
    jsonStr = parseValue(jsonStr).toString();
    try {
      var parsed = jsonDecode(jsonStr);
      print(parsed);
    } catch (e) {
      currentError = "Error parsing JSON: $e";
      print(currentError);
    }
    return;
  }

  if (cmd.startsWith('json.stringify(') && cmd.endsWith(')')) {
    String varName = cmd.substring(15, cmd.length - 1).trim();
    try {
      dynamic value = parseValue(varName);
      String jsonStr = jsonEncode(value);
      print(jsonStr);
    } catch (e) {
      currentError = "Error stringifying JSON: $e";
      print(currentError);
    }
    return;
  }

  // Cryptography operations
  if (cmd.startsWith('hash.md5(') && cmd.endsWith(')')) {
    String text = cmd.substring(9, cmd.length - 1).trim();
    text = parseValue(text).toString();
    var bytes = utf8.encode(text);
    var digest = md5.convert(bytes);
    print(digest.toString());
    return;
  }

  if (cmd.startsWith('hash.sha256(') && cmd.endsWith(')')) {
    String text = cmd.substring(12, cmd.length - 1).trim();
    text = parseValue(text).toString();
    var bytes = utf8.encode(text);
    var digest = sha256.convert(bytes);
    print(digest.toString());
    return;
  }

  if (cmd.startsWith('encode.base64(') && cmd.endsWith(')')) {
    String text = cmd.substring(14, cmd.length - 1).trim();
    text = parseValue(text).toString();
    var bytes = utf8.encode(text);
    String encoded = base64Encode(bytes);
    print(encoded);
    return;
  }

  if (cmd.startsWith('decode.base64(') && cmd.endsWith(')')) {
    String text = cmd.substring(14, cmd.length - 1).trim();
    text = parseValue(text).toString();
    try {
      var bytes = base64Decode(text);
      String decoded = utf8.decode(bytes);
      print(decoded);
    } catch (e) {
      currentError = "Error decoding base64: $e";
      print(currentError);
    }
    return;
  }

  // Import file or package
  if (cmd.startsWith('import ') || cmd.startsWith('import(')) {
    String filename;
    if (cmd.startsWith('import(') && cmd.endsWith(')')) {
      filename = cmd.substring(7, cmd.length - 1).trim();
      if (filename.startsWith('"') && filename.endsWith('"')) {
        filename = filename.substring(1, filename.length - 1);
      }
    } else {
      filename = cmd.substring(7).trim();
    }

    // If importing a package by name (no slash and no extension), run all .wsx in src/
    if (!filename.contains('/') &&
        !filename.endsWith('.ws') &&
        !filename.endsWith('.wsx') &&
        !filename.endsWith('.repl')) {
      var packages = PackageManager.loadInstalledPackages();
      if (packages.containsKey(filename)) {
        String pkgPath = packages[filename]['path'];
        String srcDir = '$pkgPath/src';
        if (Directory(srcDir).existsSync()) {
          var files = Directory(srcDir)
              .listSync()
              .whereType<File>()
              .where((f) => f.path.toLowerCase().endsWith('.wsx'))
              .toList();
          for (var f in files) {
            executeFile(f.path);
          }
          return;
        }
      }
    }

    // Specific file import: add default extension if missing
    if (!filename.endsWith('.ws') &&
        !filename.endsWith('.wsx') &&
        !filename.endsWith('.repl')) {
      filename += '.ws';
    }

    // Resolve via PackageManager (handles src/ and .wsx mapping)
    String? resolved = PackageManager.resolvePackagePath(filename);
    executeFile(resolved ?? filename);
    return;
  }

  // Run file
  if (cmd.startsWith('run ') || cmd.startsWith('run(')) {
    String filename;
    if (cmd.startsWith('run(') && cmd.endsWith(')')) {
      filename = cmd.substring(4, cmd.length - 1).trim();
      if (filename.startsWith('"') && filename.endsWith('"')) {
        filename = filename.substring(1, filename.length - 1);
      }
    } else {
      filename = cmd.substring(4).trim();
    }

    if (!filename.endsWith('.ws') && !filename.endsWith('.repl')) {
      filename += '.ws';
    }

    executeFile(filename);
    return;
  }

  // From-import: from <package> import <module>
  if (cmd.startsWith('from ')) {
    RegExp r = RegExp(r'^from\s+(\w+)\s+import\s+(\w+)$');
    Match? m = r.firstMatch(cmd.trim());
    if (m == null) {
      reportError('Invalid from-import syntax',
          line: cmd, suggestion: 'Use: from <package> import <module>');
      return;
    }
    String pkgName = m.group(1)!;
    String moduleName = m.group(2)!;

    var packages = PackageManager.loadInstalledPackages();
    if (!packages.containsKey(pkgName)) {
      reportError("Package '$pkgName' not installed", line: cmd);
      return;
    }
    String pkgPath = packages[pkgName]['path'];
    String assignPath = '$pkgPath/assignment.json';
    if (!File(assignPath).existsSync()) {
      reportError("assignment.json not found for package '$pkgName'",
          line: cmd);
      return;
    }
    try {
      var jsonMap = jsonDecode(File(assignPath).readAsStringSync());
      Map modules = (jsonMap['modules'] ?? {}) as Map;
      if (!modules.containsKey(moduleName)) {
        reportError("Module '$moduleName' not found in assignment.json",
            line: cmd);
        return;
      }
      String relFile = modules[moduleName].toString();
      String fullPath = '$pkgPath/src/$relFile';
      if (!fullPath.endsWith('.ws') && !fullPath.endsWith('.wsx')) {
        fullPath += '.wsx';
      }
      if (!File(fullPath).existsSync()) {
        reportError("Module file not found: $fullPath", line: cmd);
        return;
      }
      executeFile(fullPath);
    } catch (e) {
      reportError('Error reading assignment.json: $e', line: cmd);
    }
    return;
  }

  // command(cmd) or os.command(cmd) - run a system command and return exit code
  if ((cmd.startsWith('command(') || cmd.startsWith('os.command(')) &&
      cmd.endsWith(')')) {
    int startIdx = cmd.startsWith('os.command(') ? 11 : 8;
    String arg = cmd.substring(startIdx, cmd.length - 1).trim();
    String commandStr = arg;
    try {
      commandStr = parseValue(arg).toString();
    } catch (_) {}

    try {
      ProcessResult res = Process.runSync(Platform.isWindows ? 'cmd' : 'bash',
          [Platform.isWindows ? '/C' : '-lc', commandStr]);
      // Standalone call prints output and status
      String out = res.stdout.toString().trim();
      String err = res.stderr.toString().trim();
      if (out.isNotEmpty) print(out);
      if (err.isNotEmpty) print(err);
      print(res.exitCode);
    } catch (e) {
      print('Command error: $e');
      print(1);
    }
    return;
  }

  // sleep(ms) - pause execution for specified milliseconds
  if (cmd.startsWith('sleep(') && cmd.endsWith(')')) {
    String arg = cmd.substring(6, cmd.length - 1).trim();
    try {
      int ms = parseValue(arg) is num
          ? (parseValue(arg) as num).toInt()
          : int.parse(arg);
      sleep(Duration(milliseconds: ms));
    } catch (e) {
      reportError('Invalid sleep duration',
          line: cmd, suggestion: 'Use: sleep(1000) for 1 second');
    }
    return;
  }

  // subprocess.run(cmd) - run command synchronously and return result
  if (cmd.startsWith('subprocess.run(') && cmd.endsWith(')')) {
    String arg = cmd.substring(15, cmd.length - 1).trim();
    String commandStr = arg;
    try {
      commandStr = parseValue(arg).toString();
    } catch (_) {}

    try {
      ProcessResult res = Process.runSync(Platform.isWindows ? 'cmd' : 'bash',
          [Platform.isWindows ? '/C' : '-lc', commandStr]);
      print('stdout: ${res.stdout}');
      print('stderr: ${res.stderr}');
      print('exitCode: ${res.exitCode}');
    } catch (e) {
      print('Subprocess error: $e');
    }
    return;
  }

  // subprocess.start(cmd) - start command asynchronously (non-blocking)
  if (cmd.startsWith('subprocess.start(') && cmd.endsWith(')')) {
    String arg = cmd.substring(17, cmd.length - 1).trim();
    String commandStr = arg;
    try {
      commandStr = parseValue(arg).toString();
    } catch (_) {}

    Process.start(Platform.isWindows ? 'cmd' : 'bash',
        [Platform.isWindows ? '/C' : '-lc', commandStr]).then((process) {
      print('Process started with PID: ${process.pid}');
      process.stdout.transform(utf8.decoder).listen((data) {
        print(data);
      });
      process.stderr.transform(utf8.decoder).listen((data) {
        print(data);
      });
    }).catchError((e) {
      print('Error starting subprocess: $e');
    });
    return;
  }

  // GUI commands
  if (cmd.startsWith('gui.')) {
    handleGuiCommand(cmd);
    return;
  }

  // Canvas commands
  if (cmd.startsWith('canvas.')) {
    handleCanvasCommand(cmd);
    return;
  }

  // Handle object property assignment (obj.property = value)
  if (cmd.contains('.') &&
      cmd.contains('=') &&
      !cmd.contains('==') &&
      !cmd.contains('<=') &&
      !cmd.contains('>=') &&
      !cmd.contains('!=')) {
    int eqIdx = cmd.indexOf('=');
    String leftSide = cmd.substring(0, eqIdx).trim();

    // Check if left side is object.property
    if (leftSide.contains('.') && !leftSide.contains('(')) {
      int dotIdx = leftSide.indexOf('.');
      String objName = leftSide.substring(0, dotIdx).trim();
      String propName = leftSide.substring(dotIdx + 1).trim();

      if (variables.containsKey(objName) && variables[objName] is Map) {
        String expression = cmd.substring(eqIdx + 1).trim();
        Map<String, dynamic> obj = variables[objName];

        try {
          // Try to parse as value
          obj[propName] = parseValue(expression);
        } catch (e) {
          // Try to evaluate as expression
          try {
            // Preprocess to handle this.property references
            String preprocessed = preprocessExpression(expression);
            List<String> tokens = tokenizeExpression(preprocessed);
            double result = evaluateExpression(tokens);
            obj[propName] = result;
          } catch (e2) {
            obj[propName] = expression;
          }
        }
        return;
      }
    }
  }

  // Check for variable assignment
  // Handle compound assignment operators (+=, -=)
  if (cmd.contains('+=') || cmd.contains('-=')) {
    String operator = cmd.contains('+=') ? '+=' : '-=';
    int opIdx = cmd.indexOf(operator);
    String varName = cmd.substring(0, opIdx).trim();
    String expression = cmd.substring(opIdx + 2).trim();

    // Check if it's an object property (obj.property)
    if (varName.contains('.') && !varName.contains('(')) {
      int dotIdx = varName.indexOf('.');
      String objName = varName.substring(0, dotIdx).trim();
      String propName = varName.substring(dotIdx + 1).trim();

      if (variables.containsKey(objName) && variables[objName] is Map) {
        Map<String, dynamic> obj = variables[objName];

        if (!obj.containsKey(propName)) {
          reportError("Property '$propName' not defined on object '$objName'",
              line: cmd,
              suggestion: "Initialize the property before using $operator");
          return;
        }

        try {
          dynamic currentValue = obj[propName];
          dynamic addValue;

          // Try to parse the expression
          try {
            String preprocessed = preprocessExpression(expression);
            List<String> tokens = tokenizeExpression(preprocessed);
            addValue = evaluateExpression(tokens);
          } catch (_) {
            try {
              addValue = parseValue(expression);
            } catch (_) {
              addValue = double.parse(expression);
            }
          }

          // Perform the operation
          if (operator == '+=') {
            obj[propName] = (currentValue is num
                    ? currentValue
                    : double.parse(currentValue.toString())) +
                (addValue is num
                    ? addValue
                    : double.parse(addValue.toString()));
          } else {
            obj[propName] = (currentValue is num
                    ? currentValue
                    : double.parse(currentValue.toString())) -
                (addValue is num
                    ? addValue
                    : double.parse(addValue.toString()));
          }
        } catch (e) {
          reportError("Error in compound assignment",
              line: cmd,
              suggestion: "Ensure both values are numbers.\n  Error: $e");
        }
        return;
      }
    }

    if (!variables.containsKey(varName)) {
      reportError("Variable '$varName' not defined",
          line: cmd,
          suggestion: "Initialize the variable before using $operator");
      return;
    }

    try {
      dynamic currentValue = variables[varName];
      dynamic addValue;

      // Try to parse the expression
      try {
        String preprocessed = preprocessExpression(expression);
        List<String> tokens = tokenizeExpression(preprocessed);
        addValue = evaluateExpression(tokens);
      } catch (_) {
        try {
          addValue = parseValue(expression);
        } catch (_) {
          addValue = double.parse(expression);
        }
      }

      // Perform the operation
      if (operator == '+=') {
        variables[varName] = (currentValue is num
                ? currentValue
                : double.parse(currentValue.toString())) +
            (addValue is num ? addValue : double.parse(addValue.toString()));
      } else {
        variables[varName] = (currentValue is num
                ? currentValue
                : double.parse(currentValue.toString())) -
            (addValue is num ? addValue : double.parse(addValue.toString()));
      }
    } catch (e) {
      reportError("Error in compound assignment",
          line: cmd,
          suggestion: "Ensure both values are numbers.\n  Error: $e");
    }
    return;
  }

  if (cmd.contains('=') &&
      !cmd.contains('==') &&
      !cmd.contains('<=') &&
      !cmd.contains('>=') &&
      !cmd.contains('!=')) {
    int eqIdx = cmd.indexOf('=');
    String varName = cmd.substring(0, eqIdx).trim();
    String expression = cmd.substring(eqIdx + 1).trim();

    // Handle input() function
    if (expression.startsWith('input(') && expression.endsWith(')')) {
      String content = expression.substring(6, expression.length - 1).trim();
      if (content.isNotEmpty) {
        try {
          String prompt = parseValue(content).toString();
          stdout.write(prompt);
        } catch (e) {
          stdout.write(content);
        }
      }
      String? userInput = stdin.readLineSync();
      variables[varName] = userInput ?? "";
      return;
    }

    // Handle readFile() function
    if (expression.startsWith('readFile(') && expression.endsWith(')')) {
      String filename = expression.substring(9, expression.length - 1).trim();
      filename = parseValue(filename).toString();
      try {
        File file = File(filename);
        String content = file.readAsStringSync();
        variables[varName] = content;
      } catch (e) {
        currentError = "Error reading file: $e";
        print(currentError);
        variables[varName] = "";
      }
      return;
    }

    // Handle new ClassName() - class instantiation
    if (expression.startsWith('new ') &&
        expression.contains('(') &&
        expression.endsWith(')')) {
      RegExp newPattern = RegExp(r'new\s+(\w+)\((.*)\)');
      Match? match = newPattern.firstMatch(expression);
      if (match != null) {
        String className = match.group(1)!;
        String argsStr = match.group(2)!;

        if (classes.containsKey(className)) {
          // Create instance with properties from class definition
          Map<String, dynamic> instance = {
            '__class__': className,
            '__methods__':
                Map<String, Function>.from(classes[className]['methods'] ?? {}),
          };

          // Copy default properties
          Map<String, dynamic> classProps =
              classes[className]['properties'] ?? {};
          classProps.forEach((key, value) {
            instance[key] = value;
          });

          variables[varName] = instance;

          // Call init constructor if it exists
          if (instance['__methods__'].containsKey('init')) {
            List<dynamic> args = [];
            if (argsStr.trim().isNotEmpty) {
              List<String> argParts = splitArgs(argsStr);
              for (var arg in argParts) {
                try {
                  args.add(parseValue(arg));
                } catch (e) {
                  args.add(arg);
                }
              }
            }

            // Call init with instance context
            Function initMethod = instance['__methods__']['init'];
            initMethod(instance, args);
          }

          return;
        } else {
          reportError("Class '$className' is not defined",
              suggestion: "Define the class using: class $className ... end");
          return;
        }
      }
    }

    // Handle list literals
    if (expression.startsWith('[') && expression.endsWith(']')) {
      variables[varName] = parseList(expression);
      return;
    }

    // Handle string concatenation with + (only if it contains string literals)
    if (expression.contains('+') &&
        (expression.contains('"') || expression.contains("'"))) {
      var result = evaluateStringExpression(expression);
      if (result != null) {
        variables[varName] = result;
        return;
      }
    }

    // Handle string literals
    if ((expression.startsWith('"') && expression.endsWith('"')) ||
        (expression.startsWith("'") && expression.endsWith("'"))) {
      variables[varName] = expression.substring(1, expression.length - 1);
      return;
    }

    // Handle booleans
    if (expression == 'true' || expression == 'false') {
      variables[varName] = expression == 'true';
      return;
    }

    // Handle string methods
    if (expression.contains('.length()') || expression.contains('.letter(')) {
      try {
        variables[varName] = evaluateStringMethod(expression);
        return;
      } catch (e) {
        // Fall through to other handlers
      }
    }

    // Handle object property access (obj.property)
    if (expression.contains('.') && !expression.contains('(')) {
      int dotIdx = expression.indexOf('.');
      String objName = expression.substring(0, dotIdx).trim();
      String propName = expression.substring(dotIdx + 1).trim();

      if (variables.containsKey(objName) && variables[objName] is Map) {
        Map<String, dynamic> obj = variables[objName];
        if (obj.containsKey(propName)) {
          variables[varName] = obj[propName];
          return;
        }
      }
    }

    // Handle list indexing
    if (expression.contains('[') && expression.contains(']')) {
      var value = evaluateListAccess(expression);
      if (value != null) {
        variables[varName] = value;
        return;
      }
    }

    // Handle simple function calls (not expressions with operators)
    if (expression.contains('(') &&
        expression.endsWith(')') &&
        !expression.contains('+') &&
        !expression.contains('-') &&
        !expression.contains('*') &&
        !expression.contains('/') &&
        !expression.contains('%')) {
      int parenIdx = expression.indexOf('(');
      String funcName = expression.substring(0, parenIdx).trim();
      if (functions.containsKey(funcName)) {
        try {
          // Preprocess to handle nested function calls
          String preprocessed = preprocessExpression(expression);

          // If preprocessing replaced the entire expression with a value, use it
          if (!preprocessed.contains('(')) {
            variables[varName] = parseValue(preprocessed);
            return;
          }

          // Otherwise, parse the function call
          parenIdx = preprocessed.indexOf('(');
          String args =
              preprocessed.substring(parenIdx + 1, preprocessed.length - 1);

          // Split arguments by comma, respecting parentheses
          List<String> argStrings = [];
          int depth = 0;
          StringBuffer current = StringBuffer();

          for (int i = 0; i < args.length; i++) {
            String char = args[i];
            if (char == '(') {
              depth++;
              current.write(char);
            } else if (char == ')') {
              depth--;
              current.write(char);
            } else if (char == ',' && depth == 0) {
              argStrings.add(current.toString().trim());
              current.clear();
            } else {
              current.write(char);
            }
          }
          if (current.isNotEmpty) {
            argStrings.add(current.toString().trim());
          }

          List<dynamic> argList = argStrings.isEmpty
              ? []
              : argStrings.map((e) {
                  try {
                    return parseValue(e);
                  } catch (_) {
                    // Try to evaluate as an expression
                    try {
                      List<String> tokens = tokenizeExpression(e);
                      return evaluateExpression(tokens);
                    } catch (_) {
                      return e;
                    }
                  }
                }).toList();
          dynamic result = functions[funcName]!(argList);
          variables[varName] = result;
          return;
        } catch (e) {
          reportError("Error calling function '$funcName' in assignment",
              line: cmd,
              suggestion: "Check that all arguments are valid.\n  Error: $e");
          return;
        }
      }
    }

    // Handle numeric expressions
    // First preprocess to handle function calls
    String preprocessed = preprocessExpression(expression);
    List<String> tokens = tokenizeExpression(preprocessed);

    try {
      double result = evaluateExpression(tokens);
      variables[varName] = result;
    } catch (e) {
      reportError("Invalid expression in assignment",
          line: cmd,
          lineNum: currentLineNum,
          suggestion:
              "Check that all variables are defined and operators are valid.\n  Examples: x = 10, y = x + 5, z = x * (y + 2)");
    }
    return;
  }

  // Handle list indexing access
  if (cmd.contains('[') && cmd.contains(']')) {
    var value = evaluateListAccess(cmd);
    if (value != null) {
      print(value);
      return;
    }
  }

  // Handle object method calls (obj.method())
  if (cmd.contains('.') &&
      cmd.contains('(') &&
      cmd.endsWith(')') &&
      !cmd.contains('canvas.')) {
    int dotIdx = cmd.indexOf('.');
    String objName = cmd.substring(0, dotIdx).trim();
    String methodCall = cmd.substring(dotIdx + 1).trim();

    if (variables.containsKey(objName) && variables[objName] is Map) {
      Map<String, dynamic> obj = variables[objName];

      int parenIdx = methodCall.indexOf('(');
      String methodName = methodCall.substring(0, parenIdx).trim();
      String argsStr =
          methodCall.substring(parenIdx + 1, methodCall.length - 1).trim();

      if (obj.containsKey('__methods__') &&
          obj['__methods__'].containsKey(methodName)) {
        List<dynamic> args = [];
        if (argsStr.isNotEmpty) {
          List<String> argParts = splitArgs(argsStr);
          for (var arg in argParts) {
            try {
              args.add(parseValue(arg));
            } catch (e) {
              args.add(arg);
            }
          }
        }

        Function method = obj['__methods__'][methodName];
        method(obj, args);
        return;
      }
    }
  }

  // Handle user-defined function calls
  if (cmd.contains('(') && cmd.endsWith(')')) {
    int parenIdx = cmd.indexOf('(');
    String funcName = cmd.substring(0, parenIdx).trim();
    if (functions.containsKey(funcName)) {
      try {
        String args = cmd.substring(parenIdx + 1, cmd.length - 1);
        List<dynamic> argList = args.isEmpty
            ? []
            : args.split(',').map((e) => parseValue(e.trim())).toList();
        functions[funcName]!(argList);
        return;
      } catch (e) {
        reportError("Error calling function '$funcName'",
            line: cmd,
            suggestion: "Check that all arguments are valid.\n  Error: $e");
        return;
      }
    }
  }

  // Evaluate expression (only for direct expressions, not assignments)
  // Try string concatenation first (handles literals and input())
  if (cmd.contains('+') &&
      (cmd.contains('"') || cmd.contains("'") || cmd.contains('input('))) {
    var strResult = evaluateStringExpression(cmd);
    if (strResult != null) {
      print(strResult);
      return;
    }
  }

  // Try simple literal/variable/object value
  try {
    dynamic val = parseValue(cmd);
    print(val);
    return;
  } catch (_) {
    // fall through to numeric expression handling
  }

  List<String> tokens = tokenizeExpression(cmd);

  try {
    double result = evaluateExpression(tokens);
    print(result);
  } catch (e) {
    reportError("Invalid expression",
        suggestion:
            "Check that all variables are defined and syntax is correct.\n  Example: x + y * 2 - (z / 4)");
  }
}

List<String> splitArgs(String args) {
  List<String> result = [];
  String current = '';
  int depth = 0;
  bool inString = false;
  String stringChar = '';

  for (var i = 0; i < args.length; i++) {
    var char = args[i];

    if ((char == '"' || char == "'") && (i == 0 || args[i - 1] != '\\')) {
      if (!inString) {
        inString = true;
        stringChar = char;
      } else if (char == stringChar) {
        inString = false;
      }
      current += char;
    } else if (inString) {
      current += char;
    } else if (char == '(' || char == '[') {
      depth++;
      current += char;
    } else if (char == ')' || char == ']') {
      depth--;
      current += char;
    } else if (char == ',' && depth == 0) {
      result.add(current.trim());
      current = '';
    } else {
      current += char;
    }
  }

  if (current.isNotEmpty) {
    result.add(current.trim());
  }

  return result;
}

String? evaluateStringExpression(String expr) {
  // First, handle input() calls in the expression
  while (expr.contains('input(')) {
    int inputStart = expr.indexOf('input(');
    int parenCount = 1;
    int i = inputStart + 6; // Start after 'input('

    while (i < expr.length && parenCount > 0) {
      if (expr[i] == '(') parenCount++;
      if (expr[i] == ')') parenCount--;
      i++;
    }

    if (parenCount == 0) {
      String inputCall = expr.substring(inputStart, i);
      String promptPart = expr.substring(inputStart + 6, i - 1).trim();

      // Execute the input call
      if (promptPart.isNotEmpty) {
        try {
          String prompt = parseValue(promptPart).toString();
          stdout.write(prompt);
        } catch (e) {
          stdout.write(promptPart);
        }
      }
      String? userInput = stdin.readLineSync();

      // Replace the input() call with the actual input value
      expr = expr.replaceFirst(inputCall, '"${userInput ?? ""}"');
    } else {
      break; // Malformed input call
    }
  }

  List<String> parts = [];
  String current = '';
  bool inString = false;
  String stringChar = '';

  for (var i = 0; i < expr.length; i++) {
    var char = expr[i];

    if ((char == '"' || char == "'") && (i == 0 || expr[i - 1] != '\\')) {
      if (!inString) {
        inString = true;
        stringChar = char;
        current += char;
      } else if (char == stringChar) {
        inString = false;
        current += char;
        parts.add(current);
        current = '';
      } else {
        current += char;
      }
    } else if (inString) {
      current += char;
    } else if (char == '+') {
      if (current.trim().isNotEmpty) {
        parts.add(current.trim());
        current = '';
      }
    } else if (char != ' ' || current.isNotEmpty) {
      current += char;
    }
  }

  if (current.trim().isNotEmpty) {
    parts.add(current.trim());
  }

  if (parts.isEmpty) return null;

  String result = '';
  for (var part in parts) {
    try {
      dynamic value = parseValue(part);
      result += value.toString();
    } catch (e) {
      result += part;
    }
  }

  return result;
}

dynamic evaluateListAccess(String expr) {
  int bracketIdx = expr.indexOf('[');
  if (bracketIdx == -1) return null;

  String listName = expr.substring(0, bracketIdx).trim();
  int endBracket = expr.indexOf(']', bracketIdx);
  if (endBracket == -1) return null;

  String indexStr = expr.substring(bracketIdx + 1, endBracket).trim();

  if (!variables.containsKey(listName)) return null;
  dynamic listVar = variables[listName];

  if (listVar is! List) return null;

  try {
    int index = int.parse(indexStr);
    if (index < 0 || index >= listVar.length) {
      reportError("List index out of bounds",
          suggestion:
              "Index $index is invalid for list '$listName' with length ${listVar.length}.\n  Valid indices are 0 to ${listVar.length - 1}");
      return null;
    }
    return listVar[index];
  } catch (e) {
    // Try to evaluate index as variable
    if (variables.containsKey(indexStr)) {
      dynamic idxVal = variables[indexStr];
      if (idxVal is num) {
        int index = idxVal.toInt();
        if (index < 0 || index >= listVar.length) {
          reportError("List index out of bounds",
              suggestion:
                  "Index $index is invalid for list '$listName' with length ${listVar.length}.\n  Valid indices are 0 to ${listVar.length - 1}");
          return null;
        }
        return listVar[index];
      }
    }
  }

  return null;
}

void handleCanvasCommand(String cmd) {
  if (cmd == 'canvas.clear()') {
    canvas.clear();
  } else if (cmd == 'canvas.render()') {
    canvas.render();
  } else if (cmd.startsWith('canvas.drawTriangle(')) {
    String args = cmd.substring(20, cmd.length - 1);
    List<String> parts = splitArgs(args);
    if (parts.length == 7) {
      canvas.drawTriangle(
          double.parse(parts[0]),
          double.parse(parts[1]),
          double.parse(parts[2]),
          double.parse(parts[3]),
          double.parse(parts[4]),
          double.parse(parts[5]),
          parseValue(parts[6]).toString());
    }
  } else if (cmd.startsWith('canvas.drawCircle(')) {
    String args = cmd.substring(18, cmd.length - 1);
    List<String> parts = splitArgs(args);
    if (parts.length == 4) {
      canvas.drawCircle(double.parse(parts[0]), double.parse(parts[1]),
          double.parse(parts[2]), parseValue(parts[3]).toString());
    }
  } else if (cmd.startsWith('canvas.drawRectangle(')) {
    String args = cmd.substring(21, cmd.length - 1);
    List<String> parts = splitArgs(args);
    if (parts.length == 5) {
      canvas.drawRectangle(
          double.parse(parts[0]),
          double.parse(parts[1]),
          double.parse(parts[2]),
          double.parse(parts[3]),
          parseValue(parts[4]).toString());
    }
  } else if (cmd.startsWith('canvas.drawLine(')) {
    String args = cmd.substring(16, cmd.length - 1);
    List<String> parts = splitArgs(args);
    if (parts.length == 5) {
      canvas.drawLine(
          double.parse(parts[0]),
          double.parse(parts[1]),
          double.parse(parts[2]),
          double.parse(parts[3]),
          parseValue(parts[4]).toString());
    }
  } else if (cmd.startsWith('canvas.drawPolygon(')) {
    String args = cmd.substring(19, cmd.length - 1);
    List<String> parts = splitArgs(args);
    if (parts.length == 2) {
      dynamic pointsVal = parseValue(parts[0]);
      if (pointsVal is List) {
        List<double> points =
            pointsVal.map((e) => (e as num).toDouble()).toList();
        canvas.drawPolygon(points, parseValue(parts[1]).toString());
      }
    }
  } else if (cmd.startsWith('canvas.exportSVG(')) {
    String args = cmd.substring(17, cmd.length - 1);
    String filename = parseValue(args).toString();
    canvas.exportSVG(filename);
  }
}

Future<void> handleGuiCommand(String cmd) async {
  if (cmd.startsWith('gui.window(') && cmd.endsWith(')')) {
    String args = cmd.substring(11, cmd.length - 1);
    List<String> parts = splitArgs(args);
    if (parts.length == 3) {
      int w = (parseValue(parts[0]) as num).toInt();
      int h = (parseValue(parts[1]) as num).toInt();
      String title = parseValue(parts[2]).toString();
      guiWindow.createWindow(w, h, title);
    }
  } else if (cmd.startsWith('gui.button(') && cmd.endsWith(')')) {
    String args = cmd.substring(11, cmd.length - 1);
    List<String> parts = splitArgs(args);
    if (parts.length == 5) {
      double x = (parseValue(parts[0]) as num).toDouble();
      double y = (parseValue(parts[1]) as num).toDouble();
      double w = (parseValue(parts[2]) as num).toDouble();
      double h = (parseValue(parts[3]) as num).toDouble();
      String text = parseValue(parts[4]).toString();
      guiWindow.addButton(x, y, w, h, text);
    }
  } else if (cmd.startsWith('gui.label(') && cmd.endsWith(')')) {
    String args = cmd.substring(10, cmd.length - 1);
    List<String> parts = splitArgs(args);
    if (parts.length == 3) {
      double x = (parseValue(parts[0]) as num).toDouble();
      double y = (parseValue(parts[1]) as num).toDouble();
      String text = parseValue(parts[2]).toString();
      guiWindow.addLabel(x, y, text);
    }
  } else if (cmd.startsWith('gui.css(') && cmd.endsWith(')')) {
    String args = cmd.substring(8, cmd.length - 1);
    List<String> parts = splitArgs(args);
    if (parts.length == 1) {
      String text = parseValue(parts[0]).toString();
      guiWindow.addStyle(text);
    }
  } else if (cmd.startsWith('gui.labelcenter(') && cmd.endsWith(')')) {
    String args = cmd.substring(16, cmd.length - 1);
    List<String> parts = splitArgs(args);
    if (parts.length == 2) {
      String text = parseValue(parts[1]).toString();
      double y = (parseValue(parts[0]) as num).toDouble();
      guiWindow.addCenterLabel(y, text);
    }
  } else if (cmd.startsWith('gui.title(') && cmd.endsWith(')')) {
    String args = cmd.substring(10, cmd.length - 1);
    List<String> parts = splitArgs(args);
    if (parts.length == 1) {
      String text = parseValue(parts[0]).toString();
      guiWindow.addTitle(0.0, 0.0, text);
    }
  } else if (cmd.startsWith('gui.input(') && cmd.endsWith(')')) {
    String args = cmd.substring(10, cmd.length - 1);
    List<String> parts = splitArgs(args);
    if (parts.length == 4) {
      double x = (parseValue(parts[0]) as num).toDouble();
      double y = (parseValue(parts[1]) as num).toDouble();
      double w = (parseValue(parts[2]) as num).toDouble();
      double h = (parseValue(parts[3]) as num).toDouble();
      guiWindow.addInput(x, y, w, h);
    }
  } else if (cmd == 'gui.show()' || cmd == 'gui.show') {
    await guiWindow.show();
  } else if (cmd == 'gui.close()' || cmd == 'gui.close') {
    await guiWindow.close();
  }
}

void printHelp() {
  print("\n=== Well.. Simple v$VERSION Help ===");
  print("Variables: x = 10, name = \"Alice\", list = [1, 2, 3]");
  print("Math: +, -, *, /, %, (parentheses)");
  print("Strings: concat(), split(), + for concatenation");
  print("Lists: [1,2,3], append(list, item), length(list), list[index]");
  print("Control: if/else/end, while/end, for i in range(0,10)/end");
  print("          try ... except ... finally ... end");
  print("Functions: def name(params) ... end, name(args)");
  print("Files: import filename.ws, run filename.ws");
  print("       readFile(path), writeFile(path, content)");
  print("JSON: json.parse(str), json.stringify(obj)");
  print("Crypto: hash.md5(text), hash.sha256(text)");
  print("        encode.base64(text), decode.base64(text)");
  print("Packages: pkg.install(\"git-url\", \"name\")");
  print("          pkg.list(), pkg.remove(\"name\")");
  print("System: os.command(cmd), command(cmd), sleep(ms)");
  print("        subprocess.run(cmd), subprocess.start(cmd)");
  print("GUI: gui.window(w,h,title), gui.button(x,y,w,h,text)");
  print("     gui.label(x,y,text), gui.input(x,y,w,h)");
  print("     gui.show(), gui.close()");
  print("Version: version");
  print("Canvas: canvas.clear(), canvas.drawCircle(x,y,r,color)");
  print("        canvas.drawRectangle(x,y,w,h,color)");
  print("        canvas.drawTriangle(x1,y1,x2,y2,x3,y3,color)");
  print("        canvas.drawLine(x1,y1,x2,y2,color)");
  print("        canvas.drawPolygon([x1,y1,x2,y2,...],color)");
  print("        canvas.render(), canvas.exportSVG(\"file.svg\")");
  print("================================\n");
}

void executeFile(String filename) {
  try {
    // Try to resolve the file path (check packages)
    String? resolvedPath = PackageManager.resolvePackagePath(filename);
    if (resolvedPath == null) {
      print("Error: File '$filename' not found");
      return;
    }

    File file = File(resolvedPath);
    if (!file.existsSync()) {
      print("Error: File '$resolvedPath' not found");
      return;
    }

    // Removed logging: print("> Executing $resolvedPath");
    List<String> lines = file.readAsLinesSync();

    // Set current file for error reporting
    currentFile = resolvedPath;

    for (var i = 0; i < lines.length; i++) {
      String line = lines[i].trim();
      currentLineText = lines[i];
      currentLineNum = i + 1; // Line numbers start at 1

      // Skip empty lines and comments
      if (line.isEmpty || line.startsWith('#') || line.startsWith('//')) {
        continue;
      }

      // Handle multi-line blocks
      if (line.startsWith('def ') ||
          line.startsWith('if ') ||
          line.startsWith('while ') ||
          line.startsWith('for ') ||
          line.startsWith('class ') ||
          line.startsWith('try')) {
        List<String> block = [line];
        i++;
        int depth = 1;

        while (i < lines.length && depth > 0) {
          String blockLine = lines[i].trim();
          if (blockLine == 'end') {
            depth--;
            if (depth == 0) {
              processMultiLineCommand(block);
              break;
            }
          }
          if (blockLine.startsWith('def ') ||
              blockLine.startsWith('if ') ||
              blockLine.startsWith('while ') ||
              blockLine.startsWith('for ') ||
              blockLine.startsWith('class ') ||
              blockLine.startsWith('try')) {
            depth++;
          }
          block.add(blockLine);
          i++;
        }
      } else {
        processCommand(line);
      }
    }

    // Removed logging: print("> Finished executing $filename");
  } catch (e) {
    print("Error executing file: $e");
  }
}

void processMultiLineCommand(List<String> block) {
  String firstLine = block[0];

  if (firstLine.startsWith('class ')) {
    String className = firstLine.substring(6).trim();

    Map<String, dynamic> properties = {};
    Map<String, Function> methods = {};

    // Parse class body
    int i = 1;
    while (i < block.length) {
      String line = block[i].trim();

      // Handle property definitions (name = value)
      if (line.contains('=') &&
          !line.startsWith('def ') &&
          !_isMethodStart(line) &&
          !line.contains('==')) {
        int eqIdx = line.indexOf('=');
        String propName = line.substring(0, eqIdx).trim();
        String propValue = line.substring(eqIdx + 1).trim();

        try {
          properties[propName] = parseValue(propValue);
        } catch (e) {
          properties[propName] = propValue;
        }
        i++;
      }
      // Handle method definitions (allow missing 'def' prefix)
      else if (line.startsWith('def ') || _isMethodStart(line)) {
        // Find the end of this method
        List<String> methodBlock = [line];
        i++;
        int depth = 1;

        while (i < block.length && depth > 0) {
          String methodLine = block[i];
          String trimmed = methodLine.trim();

          // Increment depth for any block-starting keyword
          if (_startsBlock(trimmed) || _isMethodStart(trimmed)) {
            depth++;
            methodBlock.add(methodLine);
          } else if (trimmed == 'end') {
            depth--;
            if (depth > 0) {
              methodBlock.add(methodLine);
            }
          } else {
            methodBlock.add(methodLine);
          }
          i++;
        }

        // Parse method definition (normalize to start with 'def ')
        String methodLine0 = methodBlock[0].trim();
        if (!methodLine0.startsWith('def ')) {
          methodLine0 = 'def ' + methodLine0;
        }

        String methodDef = methodLine0.substring(4);
        int parenIdx = methodDef.indexOf('(');
        String methodName = methodDef.substring(0, parenIdx).trim();
        int endParen = methodDef.indexOf(')');
        String params = methodDef.substring(parenIdx + 1, endParen);
        List<String> paramList = params.isEmpty
            ? []
            : params.split(',').map((e) => e.trim()).toList();

        List<String> methodBody = methodBlock.sublist(1);

        // Create method that takes instance and args
        methods[methodName] = (Map<String, dynamic> instance, List args) {
          Map<String, dynamic> oldVars = Map.from(variables);
          hasReturned = false;
          returnValue = null;

          // Set 'this' to the current instance
          variables['this'] = instance;

          // Set parameters
          for (int i = 0; i < paramList.length && i < args.length; i++) {
            variables[paramList[i]] = args[i];
          }

          executeBlock(methodBody);

          variables = oldVars;

          dynamic result = returnValue;
          hasReturned = false;
          returnValue = null;
          return result;
        };
      } else {
        i++;
      }
    }

    classes[className] = {
      'properties': properties,
      'methods': methods,
    };

    print("> Class $className defined");
  } else if (firstLine.startsWith('def ')) {
    String funcDef = firstLine.substring(4);
    int parenIdx = funcDef.indexOf('(');
    String funcName = funcDef.substring(0, parenIdx).trim();
    int endParen = funcDef.indexOf(')');
    String params = funcDef.substring(parenIdx + 1, endParen);
    List<String> paramList =
        params.isEmpty ? [] : params.split(',').map((e) => e.trim()).toList();

    List<String> body = block.sublist(1);

    functions[funcName] = (List args) {
      Map<String, dynamic> oldVars = Map.from(variables);
      hasReturned = false;
      returnValue = null;

      for (int i = 0; i < paramList.length && i < args.length; i++) {
        variables[paramList[i]] = args[i];
      }
      executeBlock(body);
      variables = oldVars;

      dynamic result = returnValue;
      hasReturned = false;
      returnValue = null;
      return result;
    };
    // Removed logging: print("> Function $funcName defined");
  } else if (firstLine.startsWith('while ')) {
    String condition = firstLine.substring(6).trim();
    List<String> body = block.sublist(1);

    shouldBreak = false; // Reset break flag
    while (evaluateCondition(condition)) {
      executeBlock(body);
      if (shouldBreak) {
        shouldBreak = false; // Reset after breaking
        break;
      }
    }
  } else if (firstLine.startsWith('if ')) {
    String condition = firstLine.substring(3).trim();
    List<String> ifBody = [];
    List<String> elseBody = [];
    bool inElse = false;

    for (var line in block.sublist(1)) {
      if (line.trim() == 'else') {
        inElse = true;
        continue;
      }
      if (inElse) {
        elseBody.add(line);
      } else {
        ifBody.add(line);
      }
    }

    if (evaluateCondition(condition)) {
      executeBlock(ifBody);
    } else if (elseBody.isNotEmpty) {
      executeBlock(elseBody);
    }
  } else if (firstLine.startsWith('for ')) {
    RegExp forPattern = RegExp(r'for\s+(\w+)\s+in\s+range\((\d+),\s*(\d+)\)');
    Match? match = forPattern.firstMatch(firstLine);

    if (match != null) {
      String varName = match.group(1)!;
      int start = int.parse(match.group(2)!);
      int end = int.parse(match.group(3)!);
      List<String> body = block.sublist(1);

      shouldBreak = false; // Reset break flag
      for (int i = start; i < end; i++) {
        variables[varName] = i.toDouble();
        executeBlock(body);
        if (shouldBreak) {
          shouldBreak = false; // Reset after breaking
          break;
        }
      }
    }
  } else if (firstLine.startsWith('try')) {
    List<String> tryBody = [];
    List<String> exceptBody = [];
    List<String> finallyBody = [];
    String currentBlock = 'try';

    for (var line in block.sublist(1)) {
      String trimmed = line.trim();
      if (trimmed == 'except') {
        currentBlock = 'except';
        continue;
      }
      if (trimmed == 'finally') {
        currentBlock = 'finally';
        continue;
      }

      if (currentBlock == 'try') {
        tryBody.add(line);
      } else if (currentBlock == 'except') {
        exceptBody.add(line);
      } else if (currentBlock == 'finally') {
        finallyBody.add(line);
      }
    }

    // Execute try block
    currentError = null;
    try {
      executeBlock(tryBody);
    } catch (e) {
      currentError = e.toString();
      // Execute except block
      if (exceptBody.isNotEmpty) {
        variables['error'] = currentError;
        executeBlock(exceptBody);
      }
    } finally {
      // Execute finally block
      if (finallyBody.isNotEmpty) {
        executeBlock(finallyBody);
      }
    }
  }
}

List<String> tokenizeExpression(String expression) {
  List<String> tokens = [];
  String current = '';

  for (var char in expression.split('')) {
    if (char == ' ') continue;
    if (['+', '-', '*', '/', '%', '(', ')'].contains(char)) {
      if (current.isNotEmpty) {
        tokens.add(current);
        current = '';
      }
      tokens.add(char);
    } else {
      current += char;
    }
  }
  if (current.isNotEmpty) tokens.add(current);
  return tokens;
}

// Helper to detect the start of a block structure in REPL input
bool _startsBlock(String trimmed) {
  return trimmed.startsWith('def ') ||
      trimmed.startsWith('if ') ||
      trimmed.startsWith('while ') ||
      trimmed.startsWith('for ') ||
      trimmed.startsWith('try') ||
      trimmed.startsWith('class ');
}

// Detects method start lines, allowing missing 'def' prefix (e.g., init(r))
bool _isMethodStart(String trimmed) {
  if (trimmed.startsWith('def ')) return true;
  return RegExp(r'^[A-Za-z_]\w*\s*\(.*\)$').hasMatch(trimmed);
}

void main(List<String> args) {
  // Check if a file was passed as argument
  if (args.isNotEmpty) {
    String filename = args[0];
    if (!filename.endsWith('.ws') && !filename.endsWith('.repl')) {
      filename += '.ws';
    }
    executeFile(filename);
    return;
  }

  print("Well.. Simple v$VERSION");
  print("Type 'help' for available commands, 'exit()' to quit");

  while (true) {
    stdout.write(">> ");
    String? cmd = stdin.readLineSync();
    if (cmd == "exit()" || cmd == "quit()") {
      print("Exiting...");
      break;
    }

    if (cmd == "help") {
      printHelp();
      continue;
    }

    cmd = cmd!.trim();

    // Handle function definition
    if (cmd.startsWith('def ')) {
      String funcDef = cmd.substring(4);
      int parenIdx = funcDef.indexOf('(');
      String funcName = funcDef.substring(0, parenIdx).trim();
      int endParen = funcDef.indexOf(')');
      String params = funcDef.substring(parenIdx + 1, endParen);
      List<String> paramList =
          params.isEmpty ? [] : params.split(',').map((e) => e.trim()).toList();

      List<String> body = [];
      while (true) {
        stdout.write("... ");
        String? line = stdin.readLineSync();
        if (line?.trim() == 'end') break;
        body.add(line!);
      }

      functions[funcName] = (List args) {
        Map<String, dynamic> oldVars = Map.from(variables);
        hasReturned = false;
        returnValue = null;

        for (int i = 0; i < paramList.length; i++) {
          variables[paramList[i]] = args[i];
        }
        executeBlock(body);
        variables = oldVars;

        dynamic result = returnValue;
        hasReturned = false;
        returnValue = null;
        return result;
      };
      continue;
    }

    // Handle class definition
    if (cmd.startsWith('class ')) {
      List<String> block = [cmd];
      int depth = 0; // Tracks nested control blocks
      int methodDepth = 0; // Tracks method bodies so class doesn't close early
      while (true) {
        stdout.write("... ");
        String? line = stdin.readLineSync();
        if (line == null) break;
        String trimmed = line.trim();

        // Method start lines may omit the 'def' prefix; treat them as blocks
        if (_isMethodStart(trimmed)) {
          methodDepth++;
          block.add(line);
          continue;
        }

        if (_startsBlock(trimmed)) {
          depth++;
          block.add(line);
          continue;
        }

        if (trimmed == 'end') {
          if (depth > 0) {
            depth--;
            block.add(line);
            continue;
          }
          if (methodDepth > 0) {
            methodDepth--;
            block.add(line);
            continue;
          }

          block.add(line);
          break;
        }

        block.add(line);
      }
      processMultiLineCommand(block);
      continue;
    }

    // Handle function call
    if (cmd.contains('(') && cmd.endsWith(')') && !cmd.startsWith('print(')) {
      int parenIdx = cmd.indexOf('(');
      String funcName = cmd.substring(0, parenIdx).trim();
      if (functions.containsKey(funcName)) {
        String args = cmd.substring(parenIdx + 1, cmd.length - 1);
        List<dynamic> argList = args.isEmpty
            ? []
            : args.split(',').map((e) => parseValue(e.trim())).toList();
        functions[funcName]!(argList);
        continue;
      }
    }

    // Handle if statement
    if (cmd.startsWith('if ')) {
      String condition = cmd.substring(3).trim();
      if (condition.endsWith(':')) {
        condition = condition.substring(0, condition.length - 1);
      }

      List<String> ifBody = [];
      List<String> elseBody = [];
      bool inElse = false;

      int depth = 0;
      while (true) {
        stdout.write("... ");
        String? line = stdin.readLineSync();
        if (line == null) break;
        String trimmed = line.trim();

        if (_startsBlock(trimmed)) {
          depth++;
          if (inElse)
            elseBody.add(line);
          else
            ifBody.add(line);
          continue;
        }

        if (trimmed == 'end') {
          if (depth == 0) {
            break;
          } else {
            depth--;
            if (inElse)
              elseBody.add(line);
            else
              ifBody.add(line);
            continue;
          }
        }

        if (trimmed.startsWith('else')) {
          inElse = true;
          continue;
        }
        if (trimmed.startsWith('elif')) {
          print("elif not fully supported yet, use else");
          inElse = true;
          continue;
        }

        if (inElse) {
          elseBody.add(line);
        } else {
          ifBody.add(line);
        }
      }

      if (evaluateCondition(condition)) {
        executeBlock(ifBody);
      } else if (elseBody.isNotEmpty) {
        executeBlock(elseBody);
      }
      continue;
    }

    // Handle while loop
    if (cmd.startsWith('while ')) {
      String condition = cmd.substring(6).trim();
      if (condition.endsWith(':')) {
        condition = condition.substring(0, condition.length - 1);
      }

      List<String> body = [];
      int depth = 0;
      while (true) {
        stdout.write("... ");
        String? line = stdin.readLineSync();
        if (line == null) break;
        String trimmed = line.trim();

        if (_startsBlock(trimmed)) {
          depth++;
          body.add(line);
          continue;
        }

        if (trimmed == 'end') {
          if (depth == 0) {
            break;
          } else {
            depth--;
            body.add(line);
            continue;
          }
        }

        body.add(line);
      }

      shouldBreak = false; // Reset break flag
      while (evaluateCondition(condition)) {
        executeBlock(body);
        if (shouldBreak) {
          shouldBreak = false; // Reset after breaking
          break;
        }
      }
      continue;
    }

    // Handle for loop
    if (cmd.startsWith('for ')) {
      RegExp forPattern = RegExp(r'for\s+(\w+)\s+in\s+range\((\d+),\s*(\d+)\)');
      Match? match = forPattern.firstMatch(cmd);

      if (match != null) {
        String varName = match.group(1)!;
        int start = int.parse(match.group(2)!);
        int end = int.parse(match.group(3)!);

        List<String> body = [];
        int depth = 0;
        while (true) {
          stdout.write("... ");
          String? line = stdin.readLineSync();
          if (line == null) break;
          String trimmed = line.trim();

          if (_startsBlock(trimmed)) {
            depth++;
            body.add(line);
            continue;
          }

          if (trimmed == 'end') {
            if (depth == 0) {
              break;
            } else {
              depth--;
              body.add(line);
              continue;
            }
          }

          body.add(line);
        }

        shouldBreak = false; // Reset break flag
        for (int i = start; i < end; i++) {
          variables[varName] = i.toDouble();
          executeBlock(body);
          if (shouldBreak) {
            shouldBreak = false; // Reset after breaking
            break;
          }
        }
        continue;
      }
    }

    // Handle try/except/finally
    if (cmd.startsWith('try')) {
      List<String> tryBody = [];
      List<String> exceptBody = [];
      List<String> finallyBody = [];
      String currentBlock = 'try';

      int depth = 0;
      while (true) {
        stdout.write("... ");
        String? line = stdin.readLineSync();
        if (line == null) break;
        String trimmed = line.trim();

        if (_startsBlock(trimmed)) {
          depth++;
          if (currentBlock == 'try')
            tryBody.add(line);
          else if (currentBlock == 'except')
            exceptBody.add(line);
          else if (currentBlock == 'finally') finallyBody.add(line);
          continue;
        }

        if (trimmed == 'end') {
          if (depth == 0) {
            break;
          } else {
            depth--;
            if (currentBlock == 'try')
              tryBody.add(line);
            else if (currentBlock == 'except')
              exceptBody.add(line);
            else if (currentBlock == 'finally') finallyBody.add(line);
            continue;
          }
        }

        if (trimmed == 'except') {
          currentBlock = 'except';
          continue;
        }
        if (trimmed == 'finally') {
          currentBlock = 'finally';
          continue;
        }

        if (currentBlock == 'try') {
          tryBody.add(line);
        } else if (currentBlock == 'except') {
          exceptBody.add(line);
        } else if (currentBlock == 'finally') {
          finallyBody.add(line);
        }
      }

      // Execute try block
      currentError = null;
      try {
        executeBlock(tryBody);
      } catch (e) {
        currentError = e.toString();
        // Execute except block
        if (exceptBody.isNotEmpty) {
          variables['error'] = currentError;
          executeBlock(exceptBody);
        }
      } finally {
        // Execute finally block
        if (finallyBody.isNotEmpty) {
          executeBlock(finallyBody);
        }
      }
      continue;
    }

    processCommand(cmd);
  }
}
