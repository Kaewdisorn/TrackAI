import axios from 'axios';

// Discord Webhook URL
const WEBHOOK_URL = ''; 

// Convert Date to KST string
function getKSTTimestamp() {
  const now = new Date();
  const kst = new Date(now.getTime() + 9 * 60 * 60 * 1000);
  return kst.toISOString().replace('T', ' ').split('.')[0]; // e.g. 2025-11-22 16:00:00
}

// Function to send a Discord embed
// Returns true if message sent successfully, false if failed
async function sendDiscordEmbed(status) {
  const now = getKSTTimestamp();

  const statusMap = {
    ok: { color: 65280, emoji: '🟢' },
    warning: { color: 16776960, emoji: '🟡' },
    error: { color: 16711680, emoji: '🔴' }
  };

  const { color, emoji } = statusMap[status] || statusMap['ok'];

  const embedPayload = {
    embeds: [
      {
        title: `${emoji} Service Health Check`,
        description: "Current status of the API server",
        color: color,
        fields: [
          { name: "Status", value: status.toUpperCase(), inline: true },
          { name: "Timestamp (KST)", value: now, inline: true }
        ],
        footer: { text: "Health Monitoring System" },
        timestamp: now
      }
    ]
  };

  try {
    await axios.post(WEBHOOK_URL, embedPayload);
    console.log('Health check sent to Discord.');
    return true;
  } catch (err) {
    console.error('Failed to send Discord message:', err.message);
    return false;
  }
}

// Exported health controller
export const healthController = async (req, res) => {
  const status = 'ok'; // your API health logic

  const discordSuccess = await sendDiscordEmbed(status);

  res.json({
    status,
    discord: discordSuccess ? 'success' : 'fail',
    timestamp: getKSTTimestamp()
  });
};