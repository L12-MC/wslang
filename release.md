# WSLang v1.2.2 (Minor update)

## What's New in v1.2.2

### Fixes / Features

#### String concatenation with variables work
```ws
a = "Hello"
b = "World!"
c = a + " " + b
print(c)
>> Hello World!
```

#### Made json, gui, canvas, crypto, and os packages that are not imported by default

```
json.parse("{"hello": "world"}")
>>
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
ERROR
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Error: 'json' module not imported.

Problematic code:
  │ json.parse("("hello": "world")")
  └─────────────────

Suggestion:
  Add 'import json' at the top of your script.
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
import json
json.parse("{"hello": "world"}")

```