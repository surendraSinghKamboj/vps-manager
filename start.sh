echo "Building project...."
npm run build
if [ $? -ne 0 ]; then
    echo "❌ Failed to build project."
    exit 1
else
    echo "✔️ Project built successfully."
fi

echo "Starting project...."
yarn next start
if [ $? -ne 0 ]; then
    echo "❌ Failed to start project."
    exit 1
else
    echo "✔️ Project started successfully."
fi