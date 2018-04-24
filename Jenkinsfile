node {

	stage("Checkout") {
		cleanWs()
		checkout scm
	}

	stage('Test') {
		sh "make test"
	}

    stage('Build') {
        sh "make build_container"
    }

	stage("Push container") {
		sh "make push"
	}

	stage("Clean") {
		sh "make clean"
	}
}