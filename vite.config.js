import { defineConfig } from 'vite';
import laravel from 'laravel-vite-plugin';
import react from '@vitejs/plugin-react';

export default defineConfig({
    plugins: [
        laravel({
            input: 'resources/js/app.tsx',
            refresh: true,
        }),
        react(),
    ],
    server: {
        host: '0.0.0.0',
        port: 5173, // Certifique-se de que a porta não está sendo usada por outro serviço
        hmr: {
            host: 'localhost',
        },
        watch: {
            usePolling: true,
        },
    }
});
