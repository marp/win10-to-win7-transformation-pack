import re

with open('install.ps1', 'r') as f:
    content = f.read()

# Wrap script calls in try/catch if not already wrapped
scripts = [
    ('& $themeScript', 'Theme'),
    ('& $resourceScript', 'Resource'),
    ('& $sndScript', 'Sound'),
    ('& $brScript', 'Branding'),
    ('& $tileScript', 'User tiles'),
    ('& $hgScript', 'HomeGroup'),
    ('& $dpScript', 'DefaultPrograms')
]

for script_call, label in scripts:
    pattern = re.escape(script_call)
    # Match only if not already wrapped in try { ... }
    if f'try {{ {script_call}' not in content:
        content = re.sub(pattern, f'try {{ {script_call} }} catch {{ Write-Log "{label} script failed: $_" "ERROR"; return $false }}', content)

with open('install.ps1', 'w') as f:
    f.write(content)
