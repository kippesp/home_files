const path = require('path');

let input = '';
process.stdin.on('data', chunk => input += chunk);
process.stdin.on('end', () => {
  try {
    const data = JSON.parse(input);
    const model = data.model.display_name;
    const pct = data.context_window.used_percentage;
    const context = pct ? Math.round(100 - pct) + '%' : '--%';
    const home = process.env.USERPROFILE || process.env.HOME;
    const cwd = data.cwd || process.cwd();
    const rel = home && cwd.startsWith(home) ? '~' + cwd.slice(home.length).replace(/\\/g, '/') : cwd;
    console.log(`${model} | ${context} remaining | ${rel}`);
  } catch (e) {
    console.log('Error parsing status');
  }
});
