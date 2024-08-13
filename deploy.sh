# Function to check if a command exists
command_exists() {
  command -v "$1" >/dev/null 2>&1
}
 
# Check if Docker is installed
if ! command_exists docker; then
  echo "Docker is not installed. Installing Docker..."
 
  # Update package information, ensure that APT works with the HTTPS method, and that CA certificates are installed.
  sudo apt-get update
  sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
 
  # Add Docker’s official GPG key and set up the stable repository
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
 
  # Update the APT package index and install Docker
  sudo apt-get update
  sudo apt-get install -y docker-ce docker-ce-cli containerd.io
 
  # Start Docker service
  sudo systemctl start docker
  sudo systemctl enable docker
 
  echo "Docker installed successfully."
else
  echo "Docker is already installed."
fi
 
CURRENT_INSTANCE=$(sudo docker ps -a --filter ancestor="$IMAGE_NAME" --format="{{.ID}}")
 
if [ "$CURRENT_INSTANCE" ]
then
    sudo docker rm $(sudo docker stop $CURRENT_INSTANCE)
fi
 
sudo docker pull $IMAGE_NAME
 
CONTAINER_EXISTS=$(sudo docker ps -a | grep $CONTAINER_NAME)
if [ "$CONTAINER_EXISTS" ]
then 
    sudo docker stop $CONTAINER_NAME
    sudo docker rm $CONTAINER_NAME
fi
 
echo " about to run ..." 
sudo docker run -p 3000:3000 -d --name $CONTAINER_NAME $IMAGE_NAME
#check that the container is actually up
sudo docker ps -a | grep $CONTAINER_NAME