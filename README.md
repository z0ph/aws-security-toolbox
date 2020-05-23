# AWS Security Toolbox (AST) :lock:

This toolbox will bring to you all necessary tooling for SecOps on AWS for auditing and assessments purpose as a simple portable and pre-installed Docker container.

This will reduce the overhead and the headache of installation of these tools and dependencies.

## Included Tools

1. [awscli](https://aws.amazon.com/cli/)
2. [CloudMapper](https://github.com/duo-labs/cloudmapper)
3. [CloudTracker](https://github.com/duo-labs/cloudtracker)
4. [prowler](https://github.com/toniblyx/prowler)
5. [ScoutSuite](https://github.com/nccgroup/ScoutSuite)
6. [PMapper](https://github.com/nccgroup/PMapper)
7. [Enumerate-IAM](https://github.com/andresriancho/enumerate-iam)
8. [policy_sentry]()

## Getting Started

### Requirements

#### Optional (host machine)

- [aws-vault](https://github.com/99designs/aws-vault)

#### Mandatory

- Docker: [macOS](https://docs.docker.com/docker-for-mac/) or [Linux](https://docs.docker.com/install/linux/docker-ce/debian/)
- `awscli` installed & configured
- create `.env` file before building your Docker image locally (see [.env.example](./.env.example)) to set your `DEFAULT_AWS_REGION` and `PROFILE_NAME` (for aws-vault)

## Usage

Clone the repository:

        $ git clone https://github.com/z0ph/aws-security-toolbox.git
        $ make build

There is two options to use this toolbox,

- Option #1 (**Interactive**), you are using local `awscli` with `~/.aws/credentials` populated.
- Option #2 (`aws-vault`), if you want to use your local `aws-vault` installation.

*Info: Working directory within the container: `/opt/secops`*

## Option 1 (Interactive)

        $ ./ast.sh login

When you are logged into the shell of the container in interactive mode (`-it`), you will be able to perform your audit/assessment with confidence thanks to pre-populated tools.

Example:

        $ ./opt/secops/prowler/prowler -b | ansi2html -la > /tmp/prowler-report.html

*nb: `/tmp` is mapped to your own (host machine) `/tmp` folder.*

## Option 2 (`aws-vault`)

        $ ./ast.sh exec /opt/artifacts/prowler/prowler -b -s > report-prod.txt

*nb: if you are not using `default` aws-vault profile name, please modify options in `ast.sh`*

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details

## Authors

* **Victor GRENU** - *Initial work* - [zoph.io](https://github.com/zoph-io)
