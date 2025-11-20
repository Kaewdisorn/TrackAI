import express from 'express';
import cors from 'cors';
import dotenv from 'dotenv';
import routes from './routes/api.js';

dotenv.config();

const app = express();

// Middleware
app.use(cors());
app.use(express.json());

// --------------------
// API Routes
// --------------------
app.use('/api', routes); 


// --------------------
// Start server
// --------------------
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`🚀 Flutter Web served at http://localhost:${PORT}`);
});
