#. Add the docker repo

   .. code-block:: bash

      curl \-fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add \-

      add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

#. Install the docker packages

   .. code-block:: bash

      apt update && apt install docker-ce -y

#. Verify docker is up and running

   .. code-block:: bash

      docker run --rm hello-world
