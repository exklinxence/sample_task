// app.js
const express = require('express');
const mongoose = require('mongoose');
const proxyAddr = require('proxy-addr');
const app = express();

// Set trust proxy to 1 to trust only the first proxy and force IPv4
app.set('trust proxy', 1);

// MongoDB Atlas connection URI
const MONGODB_URI = 'mongodb+srv://exklinxence:DwBqXyLLy6TTUzXn@cluster0.nhww1c1.mongodb.net/';

// Connect to MongoDB Atlas
mongoose.connect(MONGODB_URI, { useNewUrlParser: true, useUnifiedTopology: true });
const db = mongoose.connection;

// Define a schema for IP data
const ipSchema = new mongoose.Schema({
    originalIP: String,
    reverseIP: String
});

// Define a model for IP data
const IP = mongoose.model('IP', ipSchema);

// Middleware to handle IP data
function saveIPToMongo(req, res, next) {
    const originalIP = getOriginalIP(req);
    const reverseIP = reverseIPAddress(originalIP);

    saveIP(originalIP, reverseIP)
        .then(() => next())
        .catch(err => {
            console.error('Error saving IP data:', err);
            res.status(500).send('Error saving IP data');
        });
}

// Get the original IP address from the request object
function getOriginalIP(req) {
    return proxyAddr(req, 'loopback');
}

// Reverse the IP address
function reverseIPAddress(ip) {
    return ip.split('.').reverse().join('.');
}

// Save IP data to MongoDB
function saveIP(originalIP, reverseIP) {
    const newIP = new IP({
        originalIP,
        reverseIP
    });
    return newIP.save();
}

// Define a route to handle incoming requests
app.get('/', (req, res) => {
    const originalIP = getOriginalIP(req);
    const reverseIP = reverseIPAddress(originalIP);

    const htmlContent = generateHTML(originalIP, reverseIP);
    res.setHeader('Content-Type', 'text/html');
    res.send(htmlContent);
});

app.get('/health', (req, res) => {
    res.status(200).send('Server is healthy!');
  });

// Generate HTML content
function generateHTML(originalIP, reverseIP) {
    return `
        <!DOCTYPE html>
        <html lang="en">
        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Reverse IP</title>
        </head>
        <body>
            <h1>Reverse IP Address</h1>
            <p>Your original IP address: ${originalIP}</p>
            <p>Reversed IP address: ${reverseIP}</p>
        </body>
        </html>
    `;
}

// Start the server
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});


//mongodb+srv://exklinxence:DwBqXyLLy6TTUzXn@cluster0.nhww1c1.mongodb.net/
