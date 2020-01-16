# AWS Security Toolbox (AST) :lock:

This toolbox will bring to you all necessary apps and tooling as a simple portable and preinstalled Docker container for SecOps on AWS, especially for auditing and assessments purpose.

This will reduce the overhead and the headache of installation these tools and dependencies.

## Included Tools

- [awscli](https://aws.amazon.com/cli/)
- [CloudMapper](https://github.com/duo-labs/cloudmapper)
- [CloudTracker](https://github.com/duo-labs/cloudtracker)
- [prowler](https://github.com/toniblyx/prowler)
- [ScoutSuite](https://github.com/nccgroup/ScoutSuite)
- [PMapper](https://github.com/nccgroup/PMapper)
- [Enumerate-IAM](https://github.com/andresriancho/enumerate-iam)

## Getting Started

### Optional (host machine)

- [aws-vault](https://github.com/99designs/aws-vault)

### Requirements

- docker [macOS](https://docs.docker.com/docker-for-mac/) or [Linux](https://docs.docker.com/install/linux/docker-ce/debian/)
- `awscli` installed & configured
- create `.env` file before building your Docker image locally (see [.env.example](./.env.example)) to set your `DEFAULT_AWS_REGION` and `PROFILE_NAME` (for aws-vault)

## Usage

Clone the repository:

        $ git clone https://github.com/z0ph/aws-security-toolbox.git

There is two options to use this toolbox,

- Option #1 (**Interactive**), you are using local `awscli` with `~/.aws/credentials` populated.
- Option #2 (`aws-vault`), you want to use your local `aws-vault` installation.

*Info: Working directory within the container: `/opt/secops`*

## Option 1 (Interactive)

        $ ./ast.sh login

When you are logged into the shell of the container in interactive mode (`-it`), you will be able to perform your audit/assessment with confidence thanks to pre-populated tools.

Example:

        $ ./opt/secops/prowler/prowler -b | ansi2html -la > /tmp/prowler-report.html

*nb: `/tmp` is mapped to your own (host machine) `/tmp` folder.*

## Option 2 (`aws-vault`)

        $ ./ast.sh exec /opt/secops/prowler/prowler -b -s > report-prod.txt 

*nb: if you are not using `default` aws-vault profile name, please modify options in `ast.sh`*

### Optional

if you want to build your own container **locally** to get latest updates from tools maintainers, run the following command.

        $ make build

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details

## Authors

* **Victor GRENU** - *Initial work* - [zoph.io](https://github.com/zoph-io)