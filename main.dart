import 'dart:io';
import 'dart:convert';
import 'package:crypto/crypto.dart';

const String VERSION = "1.0.1";

Map<String, dynamic> variables = {};
Map<String, Function> functions = {};
Map<String, dynamic> classes = {};
String? currentError;

// Error reporting
int currentLineNum = 0;
String currentLineText = "";
String currentFile = "";

void reportError(String message, {String? line, int? lineNum, String? suggestion}) {
  print("");
  print("━" * 60);
  print("❌ ERROR");
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
    print("💡 Suggestion:");
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
      print("Use pkg.install(\"git-url\", \"package-name\") to install packages.");
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
      
      // Try package_name/filename
      String fullPath = '$packagePath/$filename';
      if (File(fullPath).existsSync()) {
        return fullPath;
      }
      
      // Try with .ws extension
      if (!filename.endsWith('.ws') && !filename.endsWith('.repl')) {
        fullPath = '$packagePath/$filename.ws';
        if (File(fullPath).existsSync()) {
          return fullPath;
        }
      }
    }
    
    return null;
  }
}

// Graphics canvas
class Canvas {
  List<Map<String, dynamic>> shapes = [];
  int width = 800;
  int height = 600;
  
  void clear() {
    shapes.clear();
  }
  
  void drawTriangle(double x1, double y1, double x2, double y2, double x3, double y3, String color) {
    shapes.add({
      'type': 'triangle',
      'points': [x1, y1, x2, y2, x3, y3],
      'color': color
    });
  }
  
  void drawCircle(double x, double y, double radius, String color) {
    shapes.add({
      'type': 'circle',
      'x': x,
      'y': y,
      'radius': radius,
      'color': color
    });
  }
  
  void drawRectangle(double x, double y, double width, double height, String color) {
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
    shapes.add({
      'type': 'polygon',
      'points': points,
      'color': color
    });
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
    svg.writeln('<svg width="$width" height="$height" xmlns="http://www.w3.org/2000/svg">');
    
    for (var shape in shapes) {
      switch (shape['type']) {
        case 'circle':
          svg.writeln('  <circle cx="${shape['x']}" cy="${shape['y']}" r="${shape['radius']}" fill="${shape['color']}" />');
          break;
        case 'rectangle':
          svg.writeln('  <rect x="${shape['x']}" y="${shape['y']}" width="${shape['width']}" height="${shape['height']}" fill="${shape['color']}" />');
          break;
        case 'triangle':
          var pts = shape['points'];
          svg.writeln('  <polygon points="${pts[0]},${pts[1]} ${pts[2]},${pts[3]} ${pts[4]},${pts[5]}" fill="${shape['color']}" />');
          break;
        case 'polygon':
          var pts = shape['points'] as List;
          var pointStr = '';
          for (var i = 0; i < pts.length; i += 2) {
            pointStr += '${pts[i]},${pts[i + 1]} ';
          }
          svg.writeln('  <polygon points="$pointStr" fill="${shape['color']}" />');
          break;
        case 'line':
          svg.writeln('  <line x1="${shape['x1']}" y1="${shape['y1']}" x2="${shape['x2']}" y2="${shape['y2']}" stroke="${shape['color']}" stroke-width="2" />');
          break;
      }
    }
    
    svg.writeln('</svg>');
    file.writeAsStringSync(svg.toString());
  }
}

Canvas canvas = Canvas();

String calculate(String num1, String num2, String op) {
  if(!['+', '-', '*', '/', '%'].contains(op)) {
    reportError(
      "Invalid operator: $op",
      suggestion: "Valid operators are: +, -, *, /, %"
    );
    return num2;
  }
  if (op == '/' && double.tryParse(num2) == 0) {
    reportError(
      "Division by zero",
      suggestion: "Cannot divide by zero. Check your divisor value."
    );
    return num2;
  }
  double result;
  if(op == "+"){
    result = double.parse(num1) + double.parse(num2);
  } else if(op == "-"){
    result = double.parse(num1) - double.parse(num2);
  } else if(op == "*"){
    result = double.parse(num1) * double.parse(num2);
  } else if(op == "/"){
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
      String result = calculate(tokens[i-1], tokens[i+1], tokens[i]);
      tokens.replaceRange(i-1, i+2, [result]);
      i -= 2;
    }
  }
  
  for (int i = 1; i < tokens.length; i += 2) {
    if (['+', '-'].contains(tokens[i])) {
      String result = calculate(tokens[i-1], tokens[i+1], tokens[i]);
      tokens.replaceRange(i-1, i+2, [result]);
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
          case '<': return (left as num) < (right as num);
          case '>': return (left as num) > (right as num);
          case '<=': return (left as num) <= (right as num);
          case '>=': return (left as num) >= (right as num);
          case '==': return left == right;
          case '!=': return left != right;
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
  for (var cmd in commands) {
    processCommand(cmd);
  }
}

void processCommand(String cmd) {
  cmd = cmd.trim();
  if (cmd.isEmpty) return;
  
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
      print("Usage: pkg.install(\"git-url\") or pkg.install(\"git-url\", \"package-name\")");
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
        print("Installation failed. Make sure git is installed and the URL is correct.");
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
      if (variables.containsKey(content)) {
        print(variables[content]);
      } else {
        print("Error: Invalid print argument.");
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
      // Direct call - print the prompt and return input
      if (content.isNotEmpty) {
        try {
          String prompt = parseValue(content).toString();
          stdout.write(prompt);
        } catch (e) {
          // Just use the content as-is
          stdout.write(content);
        }
      }
      String? userInput = stdin.readLineSync();
      print(userInput ?? "");
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
    String filename = cmd.substring(9, cmd.length - 1).trim();
    filename = parseValue(filename).toString();
    try {
      File file = File(filename);
      String content = file.readAsStringSync();
      print(content);
    } catch (e) {
      currentError = "Error reading file: $e";
      print(currentError);
    }
    return;
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
  
  // Import file
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
    
    if (!filename.endsWith('.ws') && !filename.endsWith('.repl')) {
      filename += '.ws';
    }
    
    executeFile(filename);
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
  
  // Canvas commands
  if (cmd.startsWith('canvas.')) {
    handleCanvasCommand(cmd);
    return;
  }
  
  // Check for variable assignment
  if (cmd.contains('=') && !cmd.contains('==') && !cmd.contains('<=') && !cmd.contains('>=') && !cmd.contains('!=')) {
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
    
    // Handle list literals
    if (expression.startsWith('[') && expression.endsWith(']')) {
      variables[varName] = parseList(expression);
      return;
    }
    
    // Handle string concatenation with +
    if (expression.contains('+') && !RegExp(r'^\d').hasMatch(expression)) {
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
    
    // Handle list indexing
    if (expression.contains('[') && expression.contains(']')) {
      var value = evaluateListAccess(expression);
      if (value != null) {
        variables[varName] = value;
        return;
      }
    }
    
    // Handle numeric expressions
    List<String> tokens = tokenizeExpression(expression);
    
    try {
      double result = evaluateExpression(tokens);
      variables[varName] = result;
    } catch (e) {
      reportError(
        "Invalid expression in assignment",
        line: cmd,
        lineNum: currentLineNum,
        suggestion: "Check that all variables are defined and operators are valid.\n  Examples: x = 10, y = x + 5, z = x * (y + 2)"
      );
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
  
  // Evaluate expression (only for direct expressions, not assignments)
  List<String> tokens = tokenizeExpression(cmd);
  
  try {
    double result = evaluateExpression(tokens);
    print(result);
  } catch (e) {
    reportError(
      "Invalid expression",
      suggestion: "Check that all variables are defined and syntax is correct.\n  Example: x + y * 2 - (z / 4)"
    );
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
      reportError(
        "List index out of bounds",
        suggestion: "Index $index is invalid for list '$listName' with length ${listVar.length}.\n  Valid indices are 0 to ${listVar.length - 1}"
      );
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
          reportError(
            "List index out of bounds",
            suggestion: "Index $index is invalid for list '$listName' with length ${listVar.length}.\n  Valid indices are 0 to ${listVar.length - 1}"
          );
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
        parseValue(parts[6]).toString()
      );
    }
  } else if (cmd.startsWith('canvas.drawCircle(')) {
    String args = cmd.substring(18, cmd.length - 1);
    List<String> parts = splitArgs(args);
    if (parts.length == 4) {
      canvas.drawCircle(
        double.parse(parts[0]),
        double.parse(parts[1]),
        double.parse(parts[2]),
        parseValue(parts[3]).toString()
      );
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
        parseValue(parts[4]).toString()
      );
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
        parseValue(parts[4]).toString()
      );
    }
  } else if (cmd.startsWith('canvas.drawPolygon(')) {
    String args = cmd.substring(19, cmd.length - 1);
    List<String> parts = splitArgs(args);
    if (parts.length == 2) {
      dynamic pointsVal = parseValue(parts[0]);
      if (pointsVal is List) {
        List<double> points = pointsVal.map((e) => (e as num).toDouble()).toList();
        canvas.drawPolygon(points, parseValue(parts[1]).toString());
      }
    }
  } else if (cmd.startsWith('canvas.exportSVG(')) {
    String args = cmd.substring(17, cmd.length - 1);
    String filename = parseValue(args).toString();
    canvas.exportSVG(filename);
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
    
    print("> Executing $resolvedPath");
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
      if (line.startsWith('def ') || line.startsWith('if ') || 
          line.startsWith('while ') || line.startsWith('for ') ||
          line.startsWith('class ') || line.startsWith('try')) {
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
          if (blockLine.startsWith('def ') || blockLine.startsWith('if ') || 
              blockLine.startsWith('while ') || blockLine.startsWith('for ') ||
              blockLine.startsWith('class ') || blockLine.startsWith('try')) {
            depth++;
          }
          block.add(blockLine);
          i++;
        }
      } else {
        processCommand(line);
      }
    }
    
    print("> Finished executing $filename");
  } catch (e) {
    print("Error executing file: $e");
  }
}

void processMultiLineCommand(List<String> block) {
  String firstLine = block[0];
  
  if (firstLine.startsWith('def ')) {
    String funcDef = firstLine.substring(4);
    int parenIdx = funcDef.indexOf('(');
    String funcName = funcDef.substring(0, parenIdx).trim();
    int endParen = funcDef.indexOf(')');
    String params = funcDef.substring(parenIdx + 1, endParen);
    List<String> paramList = params.isEmpty ? [] : params.split(',').map((e) => e.trim()).toList();
    
    List<String> body = block.sublist(1);
    
    functions[funcName] = (List args) {
      Map<String, dynamic> oldVars = Map.from(variables);
      for (int i = 0; i < paramList.length && i < args.length; i++) {
        variables[paramList[i]] = args[i];
      }
      executeBlock(body);
      variables = oldVars;
    };
    print("> Function $funcName defined");
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
    if(cmd == "exit()" || cmd == "quit()") {
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
      List<String> paramList = params.isEmpty ? [] : params.split(',').map((e) => e.trim()).toList();
      
      List<String> body = [];
      while (true) {
        stdout.write("... ");
        String? line = stdin.readLineSync();
        if (line?.trim() == 'end') break;
        body.add(line!);
      }
      
      functions[funcName] = (List args) {
        Map<String, dynamic> oldVars = Map.from(variables);
        for (int i = 0; i < paramList.length; i++) {
          variables[paramList[i]] = args[i];
        }
        executeBlock(body);
        variables = oldVars;
      };
      continue;
    }
    
    // Handle function call
    if (cmd.contains('(') && cmd.endsWith(')') && !cmd.startsWith('print(')) {
      int parenIdx = cmd.indexOf('(');
      String funcName = cmd.substring(0, parenIdx).trim();
      if (functions.containsKey(funcName)) {
        String args = cmd.substring(parenIdx + 1, cmd.length - 1);
        List<dynamic> argList = args.isEmpty ? [] : args.split(',').map((e) => parseValue(e.trim())).toList();
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
      
      while (true) {
        stdout.write("... ");
        String? line = stdin.readLineSync();
        if (line?.trim() == 'end') break;
        if (line?.trim().startsWith('else') == true) {
          inElse = true;
          continue;
        }
        if (line?.trim().startsWith('elif') == true) {
          print("elif not fully supported yet, use else");
          inElse = true;
          continue;
        }
        if (inElse) {
          elseBody.add(line!);
        } else {
          ifBody.add(line!);
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
      while (true) {
        stdout.write("... ");
        String? line = stdin.readLineSync();
        if (line?.trim() == 'end') break;
        body.add(line!);
      }
      
      while (evaluateCondition(condition)) {
        executeBlock(body);
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
        while (true) {
          stdout.write("... ");
          String? line = stdin.readLineSync();
          if (line?.trim() == 'end') break;
          body.add(line!);
        }
        
        for (int i = start; i < end; i++) {
          variables[varName] = i.toDouble();
          executeBlock(body);
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
      
      while (true) {
        stdout.write("... ");
        String? line = stdin.readLineSync();
        String trimmed = line?.trim() ?? '';
        
        if (trimmed == 'end') break;
        if (trimmed == 'except') {
          currentBlock = 'except';
          continue;
        }
        if (trimmed == 'finally') {
          currentBlock = 'finally';
          continue;
        }
        
        if (currentBlock == 'try') {
          tryBody.add(line!);
        } else if (currentBlock == 'except') {
          exceptBody.add(line!);
        } else if (currentBlock == 'finally') {
          finallyBody.add(line!);
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
