import express from 'express';
import { exec } from 'child_process';
import bodyParser from 'body-parser';

const app = express();
const PORT = 5000;

app.use(bodyParser.json());

app.get('/', (req, res) => {
    exec('cd ../code && ./main.sh', (err, stdout, stderr) => {
        if (err) {
            console.error('Error:', err);
            res.status(500).send("<p>Internal Server Error</p>");
        } else if (stderr) {
            console.error('Command stderr:', stderr);
            res.status(400).send(`<p>${stderr}</p>`);
        } else {
            console.log('Command output:\n', stdout);
            res.status(200).send(stdout);
        }
    });
});

app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT} (http://localhost:${PORT}/)`);
});
