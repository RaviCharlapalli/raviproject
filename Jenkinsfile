node() {
    stage("checkout from GIT") {
        git branch: 'main', credentialsId: 'GITHUB', url: 'https://github.com/RaviCharlapalli/raviproject.git'
    }
    stage("Build thru Maven") {
        def mvnHOME = tool name: 'M2_HOME', type: 'maven'
        def mvnPATH = "${mvnHOME}/bin/mvn"
        sh "${mvnPATH} clean package"
    }
    stage("Creating an Docker Image") {
        sh "docker build -t ravicharlapalli/scriptive:5.0 ."
    }
    stage("push image to DockerHub") {
        withCredentials([string(credentialsId: 'DockerHubPWD', variable: 'DockerHubPWD')]) {
            sh "docker login -u ravicharlapalli -p ${DockerHubPWD}"
        }
        sh "docker push ravicharlapalli/scriptive:5.0"
    }
    stage("removing existing container") {
        def removeContainer = "docker rm -f scriptivecontainer"
        try {
            sshagent(['ec2-user']) {
            sh "ssh -o StrictHostKeyChecking=no ec2-user@18.207.208.227 ${removeContainer}"
        }
        }
        catch(error) {
            sh "echo No Container Exists"
        }
    }
    stage("creating docker container") {
        def runContainer = "docker run -itd --name scriptivecontainer -p 8080:8080 ravicharlapalli/scriptive:5.0"
        sshagent(['ec2-user']) {
            sh "ssh -o StrictHostKeyChecking=no ec2-user@18.207.208.227 ${runContainer}"

        }
    }
    }
