# install colima and setup for docker to be run automatically
brew services start colima
# colima start --memory 8 --cpu 4
colima start --runtime docker
colima stop
brew services stop colima
brew services start colima
