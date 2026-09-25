# nvm installation
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.5/install.sh | bash

# homebrew is used to install cli programs and gui apps
# mas is used to install apps from app store


brew install colima

# Additional linking setups are required for docker on colima follow the official document below.
# https://colima.run/docs/installation/#all-in-one-docker-setup
brew install docker docker-compose docker-buildx
mkdir -p ~/.docker/cli-plugins
ln -sfn $(brew --prefix)/opt/docker-compose/bin/docker-compose ~/.docker/cli-plugins/docker-compose
ln -sfn $(brew --prefix)/opt/docker-buildx/bin/docker-buildx ~/.docker/cli-plugins/docker-buildx
