const vscode = require('vscode');

// Built-in functions and their signatures
const builtInFunctions = [
    { label: 'print', detail: 'print(value)', documentation: 'Print a value to the console' },
    { label: 'input', detail: 'input(prompt)', documentation: 'Get input from the user' },
    { label: 'readFile', detail: 'readFile(path)', documentation: 'Read content from a file' },
    { label: 'writeFile', detail: 'writeFile(path, content)', documentation: 'Write content to a file' },
    { label: 'sleep', detail: 'sleep(ms)', documentation: 'Pause execution for specified milliseconds' },
    { label: 'append', detail: 'append(list, item)', documentation: 'Append an item to a list' },
    { label: 'length', detail: 'length(list)', documentation: 'Get the length of a list' },
    { label: 'concat', detail: 'concat(str1, str2)', documentation: 'Concatenate two strings' },
    { label: 'split', detail: 'split(str, delimiter)', documentation: 'Split a string by delimiter' },
    { label: 'command', detail: 'command(cmd)', documentation: 'Execute a system command and return exit code' },
    { label: 'version', detail: 'version', documentation: 'Display the version information' },
];

const osCommands = [
    { label: 'os.command', detail: 'os.command(cmd)', documentation: 'Execute a system command' },
];

const subprocessCommands = [
    { label: 'subprocess.run', detail: 'subprocess.run(cmd)', documentation: 'Run a command synchronously' },
    { label: 'subprocess.start', detail: 'subprocess.start(cmd)', documentation: 'Start a command asynchronously' },
];

const jsonFunctions = [
    { label: 'json.parse', detail: 'json.parse(str)', documentation: 'Parse JSON string' },
    { label: 'json.stringify', detail: 'json.stringify(obj)', documentation: 'Convert object to JSON string' },
];

const hashFunctions = [
    { label: 'hash.md5', detail: 'hash.md5(text)', documentation: 'Generate MD5 hash' },
    { label: 'hash.sha256', detail: 'hash.sha256(text)', documentation: 'Generate SHA256 hash' },
];

const encodingFunctions = [
    { label: 'encode.base64', detail: 'encode.base64(text)', documentation: 'Encode text to base64' },
    { label: 'decode.base64', detail: 'decode.base64(text)', documentation: 'Decode base64 text' },
];

const canvasFunctions = [
    { label: 'canvas.clear', detail: 'canvas.clear()', documentation: 'Clear the canvas' },
    { label: 'canvas.render', detail: 'canvas.render()', documentation: 'Render the canvas' },
    { label: 'canvas.drawCircle', detail: 'canvas.drawCircle(x, y, radius, color)', documentation: 'Draw a circle' },
    { label: 'canvas.drawRectangle', detail: 'canvas.drawRectangle(x, y, width, height, color)', documentation: 'Draw a rectangle' },
    { label: 'canvas.drawTriangle', detail: 'canvas.drawTriangle(x1, y1, x2, y2, x3, y3, color)', documentation: 'Draw a triangle' },
    { label: 'canvas.drawLine', detail: 'canvas.drawLine(x1, y1, x2, y2, color)', documentation: 'Draw a line' },
    { label: 'canvas.drawPolygon', detail: 'canvas.drawPolygon([points], color)', documentation: 'Draw a polygon' },
    { label: 'canvas.exportSVG', detail: 'canvas.exportSVG(filename)', documentation: 'Export canvas to SVG file' },
];

const guiFunctions = [
    { label: 'gui.window', detail: 'gui.window(width, height, title)', documentation: 'Create a GUI window' },
    { label: 'gui.button', detail: 'gui.button(x, y, width, height, text)', documentation: 'Add a button to the GUI' },
    { label: 'gui.label', detail: 'gui.label(x, y, text)', documentation: 'Add a label to the GUI' },
    { label: 'gui.input', detail: 'gui.input(x, y, width, height)', documentation: 'Add an input field to the GUI' },
    { label: 'gui.show', detail: 'gui.show()', documentation: 'Show the GUI window' },
    { label: 'gui.close', detail: 'gui.close()', documentation: 'Close the GUI window' },
];

const pkgFunctions = [
    { label: 'pkg.install', detail: 'pkg.install(url, name)', documentation: 'Install a package from Git' },
    { label: 'pkg.list', detail: 'pkg.list()', documentation: 'List installed packages' },
    { label: 'pkg.remove', detail: 'pkg.remove(name)', documentation: 'Remove an installed package' },
];

const keywords = [
    { label: 'if', detail: 'if condition', documentation: 'Conditional statement' },
    { label: 'else', detail: 'else', documentation: 'Else clause' },
    { label: 'while', detail: 'while condition', documentation: 'While loop' },
    { label: 'for', detail: 'for var in range(start, end)', documentation: 'For loop' },
    { label: 'def', detail: 'def function_name(params)', documentation: 'Define a function' },
    { label: 'class', detail: 'class ClassName', documentation: 'Define a class' },
    { label: 'end', detail: 'end', documentation: 'End a block' },
    { label: 'break', detail: 'break', documentation: 'Break out of a loop' },
    { label: 'return', detail: 'return value', documentation: 'Return from a function' },
    { label: 'try', detail: 'try', documentation: 'Try-except block' },
    { label: 'except', detail: 'except', documentation: 'Exception handler' },
    { label: 'finally', detail: 'finally', documentation: 'Finally clause' },
    { label: 'import', detail: 'import module', documentation: 'Import a module' },
    { label: 'from', detail: 'from package import module', documentation: 'Import specific module from package' },
    { label: 'this', detail: 'this', documentation: 'Reference to current instance' },
    { label: 'new', detail: 'new ClassName()', documentation: 'Create a new instance of a class' },
];

// Completion provider
const completionProvider = vscode.languages.registerCompletionItemProvider('wslang', {
    provideCompletionItems(document, position, token, context) {
        const items = [];
        
        // Add all built-in functions
        [...builtInFunctions, ...osCommands, ...subprocessCommands, ...jsonFunctions, 
         ...hashFunctions, ...encodingFunctions, ...canvasFunctions, ...guiFunctions, ...pkgFunctions].forEach(func => {
            const item = new vscode.CompletionItem(func.label, vscode.CompletionItemKind.Function);
            item.detail = func.detail;
            item.documentation = new vscode.MarkdownString(func.documentation);
            item.insertText = func.label;
            items.push(item);
        });
        
        // Add keywords
        keywords.forEach(kw => {
            const item = new vscode.CompletionItem(kw.label, vscode.CompletionItemKind.Keyword);
            item.detail = kw.detail;
            item.documentation = new vscode.MarkdownString(kw.documentation);
            items.push(item);
        });
        
        // Extract variables from document
        const text = document.getText();
        const varRegex = /^(\w+)\s*=/gm;
        let match;
        const variables = new Set();
        while ((match = varRegex.exec(text)) !== null) {
            variables.add(match[1]);
        }
        
        variables.forEach(varName => {
            const item = new vscode.CompletionItem(varName, vscode.CompletionItemKind.Variable);
            item.detail = 'Variable';
            items.push(item);
        });
        
        // Extract function names
        const funcRegex = /^def\s+(\w+)/gm;
        const functions = new Set();
        while ((match = funcRegex.exec(text)) !== null) {
            functions.add(match[1]);
        }
        
        functions.forEach(funcName => {
            const item = new vscode.CompletionItem(funcName, vscode.CompletionItemKind.Function);
            item.detail = 'User function';
            items.push(item);
        });
        
        // Extract class names
        const classRegex = /^class\s+(\w+)/gm;
        const classes = new Set();
        while ((match = classRegex.exec(text)) !== null) {
            classes.add(match[1]);
        }
        
        classes.forEach(className => {
            const item = new vscode.CompletionItem(className, vscode.CompletionItemKind.Class);
            item.detail = 'Class';
            items.push(item);
        });
        
        return items;
    }
});

// Diagnostic provider for error detection
function updateDiagnostics(document, collection) {
    if (document.languageId !== 'wslang') {
        return;
    }
    
    const diagnostics = [];
    const text = document.getText();
    const lines = text.split('\n');
    
    // Track block depth
    let blockStack = [];
    
    for (let i = 0; i < lines.length; i++) {
        const line = lines[i].trim();
        
        // Skip empty lines and comments
        if (!line || line.startsWith('#')) {
            continue;
        }
        
        // Check for block start
        if (line.match(/^(if|while|for|def|class|try)\b/)) {
            blockStack.push({ type: line.split(/\s+/)[0], line: i });
        }
        
        // Check for block end
        if (line === 'end') {
            if (blockStack.length === 0) {
                const range = new vscode.Range(i, 0, i, line.length);
                const diagnostic = new vscode.Diagnostic(
                    range,
                    'Unexpected "end" without matching block start',
                    vscode.DiagnosticSeverity.Error
                );
                diagnostics.push(diagnostic);
            } else {
                blockStack.pop();
            }
        }
        
        // Check for undefined variables in assignments
        const assignMatch = line.match(/^(\w+)\s*=\s*(.+)/);
        if (assignMatch && assignMatch[2]) {
            const expr = assignMatch[2];
            // Check if right side uses undefined variables
            const varUsage = expr.match(/\b([a-zA-Z_]\w*)\b/g);
            if (varUsage) {
                const definedVars = new Set();
                for (let j = 0; j < i; j++) {
                    const prevLine = lines[j].trim();
                    const defMatch = prevLine.match(/^(\w+)\s*=/);
                    if (defMatch) {
                        definedVars.add(defMatch[1]);
                    }
                }
                
                varUsage.forEach(usedVar => {
                    // Skip built-in functions and keywords
                    const builtins = ['print', 'input', 'true', 'false', 'null', 'this', 'range'];
                    if (!builtins.includes(usedVar) && !definedVars.has(usedVar)) {
                        // Could be undefined (but might be a function or class)
                        // Only warn, not error
                    }
                });
            }
        }
        
        // Check for missing parentheses in function calls
        const funcMatch = line.match(/\b(print|input|sleep|append|length)\s+[^(]/);
        if (funcMatch) {
            const range = new vscode.Range(i, 0, i, line.length);
            const diagnostic = new vscode.Diagnostic(
                range,
                `Function "${funcMatch[1]}" requires parentheses`,
                vscode.DiagnosticSeverity.Warning
            );
            diagnostics.push(diagnostic);
        }
    }
    
    // Check for unclosed blocks
    if (blockStack.length > 0) {
        blockStack.forEach(block => {
            const range = new vscode.Range(block.line, 0, block.line, lines[block.line].length);
            const diagnostic = new vscode.Diagnostic(
                range,
                `Block "${block.type}" is not closed with "end"`,
                vscode.DiagnosticSeverity.Error
            );
            diagnostics.push(diagnostic);
        });
    }
    
    collection.set(document.uri, diagnostics);
}

// Activate extension
function activate(context) {
    console.log('Well.. Simple language extension is now active');
    
    // Register completion provider
    context.subscriptions.push(completionProvider);
    
    // Register diagnostic collection
    const diagnosticCollection = vscode.languages.createDiagnosticCollection('wslang');
    context.subscriptions.push(diagnosticCollection);
    
    // Update diagnostics on document change
    if (vscode.window.activeTextEditor) {
        updateDiagnostics(vscode.window.activeTextEditor.document, diagnosticCollection);
    }
    
    context.subscriptions.push(
        vscode.window.onDidChangeActiveTextEditor(editor => {
            if (editor) {
                updateDiagnostics(editor.document, diagnosticCollection);
            }
        })
    );
    
    context.subscriptions.push(
        vscode.workspace.onDidChangeTextDocument(e => {
            updateDiagnostics(e.document, diagnosticCollection);
        })
    );
    
    context.subscriptions.push(
        vscode.workspace.onDidOpenTextDocument(doc => {
            updateDiagnostics(doc, diagnosticCollection);
        })
    );
}

// Deactivate extension
function deactivate() {}

module.exports = {
    activate,
    deactivate
};
