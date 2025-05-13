# Use the official Flutter image
FROM cirrusci/flutter:stable

# Install necessary dependencies
RUN apt-get update && apt-get install -y \
    libglu1-mesa \
    curl \
    git \
    unzip \
    xz-utils \
    zip \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory in the container
WORKDIR /workspace

# Copy the Flutter app files into the container
COPY . /workspace

# Get Flutter dependencies
RUN flutter doctor

# Get Flutter packages
RUN flutter pub get

# Expose a port (if you want to run a server or interact)
EXPOSE 8080

# Default command to run the Flutter app (could be different based on your needs)
CMD ["flutter", "run"]
