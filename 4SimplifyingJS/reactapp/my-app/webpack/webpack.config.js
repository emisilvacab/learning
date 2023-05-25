const path = require('path');
module.exports = {
    entry: './src/index.js',
    module: {
        loaders: [
            {
                test: /\.png?/,
                use: [
                    {
                        loader: 'file-loader',
                        options: {
                            outputPath: 'build',
                        },
                    },
                ],
            },
            {
                test: /\.css$/,
                use: [
                    'style-loader',
                    'css-loader',
                ],
            },
            {
                test: /\.js?/,
                use: 'babel-loader',
            },
        ],
    },
    output: {
        filename: 'build/bundle.js',
        path: path.resolve(__dirname),
    },
};