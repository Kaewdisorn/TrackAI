import express from 'express';
import cors from 'cors';
import dotenv from 'dotenv';
import path from 'path';
import { fileURLToPath } from 'url';
import routes from './routes/api.js';

dotenv.config();

const app = express();

// Middleware
app.use(cors());
app.use(express.json());

// Resolve __dirname for ES module
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

// --------------------
// API Routes
// --------------------
app.use('/api', routes); 

// --------------------
// Serve Flutter Web static files
// --------------------
const flutterBuildPath = path.join(__dirname, '../../flutter_project/build/web');
app.use(express.static(flutterBuildPath));

// SPA fallback for non-API routes
app.get(/^\/(?!api).*/, (req, res) => {
  res.sendFile(path.join(flutterBuildPath, 'index.html'));
});

// --------------------
// Start server
// --------------------
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`🚀 Flutter Web served at http://localhost:${PORT}`);
});
