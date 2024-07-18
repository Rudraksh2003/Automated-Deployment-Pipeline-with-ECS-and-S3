#!/bin/bash

# Export the GIT_REPOSITORY__URL environment variable
export GIT_REPOSITORY__URL="$GIT_REPOSITORY__URL"

# Clone the repository
git clone "$GIT_REPOSITORY__URL" /home/app/output

# Execute the Node.js script
exec node script.js
