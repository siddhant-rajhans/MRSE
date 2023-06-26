// const modeSwitch = document.getElementById('modeSwitch');

// modeSwitch.addEventListener('change', function() {
//   document.body.classList.toggle('dark-mode');
// });


const modeSwitch = document.getElementById('modeSwitch');
modeSwitch.addEventListener('change', function() {
  document.body.classList.toggle('dark-mode');

  if (document.body.classList.contains('dark-mode')) {
    localStorage.setItem('theme', 'dark');
  } else {
    localStorage.setItem('theme', 'light');
  }
});

function setInitialTheme() {
  const savedTheme = localStorage.getItem('theme');

  if (savedTheme === 'dark') {
    document.body.classList.add('dark-mode');
    modeSwitch.checked = true;
  }
}

setInitialTheme();

const qrCodeElement = document.getElementById('qrcode');
const domainLink = 'https://www.google.com'; // Replace with your actual domain link

new QRCode(qrCodeElement, {
  text: domainLink,
  width: 128,
  height: 128,
});
