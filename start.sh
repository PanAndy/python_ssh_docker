#!/bin/bash

__create_user() {
    # Set the desired username and password
    USERNAME="admin"
    PASSWORD="164716"

    # Create the user
    useradd $USERNAME
    echo -e "$PASSWORD\n$PASSWORD" | (passwd --stdin $USERNAME)
    echo "SSH $USERNAME password: $PASSWORD"
}

# Call all functions
__create_user