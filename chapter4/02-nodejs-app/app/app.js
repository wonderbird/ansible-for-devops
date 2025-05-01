// Load the express module.
const express = require('express');
let app = express();

// Respond to requests for / with "Hello World!".
app.get('/', (req, res) => {
    res.send('Hello World!');
});

// Listen on port 80 (like a true web server).
app.listen(80, () => console.log('Express server started successfully.'));
