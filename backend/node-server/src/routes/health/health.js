import { Router } from 'express';
import { healthController } from '../../controllers/health.js';

const router = Router();

router.get('/', healthController);

export default router;