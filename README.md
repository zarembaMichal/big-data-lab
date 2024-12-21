

## How to use this repo

1. Fork this repo
![Fork instructions](image.png)
2. Change parameters in `notebooks/conf/00_env_variables.ipynb`:
    - USER_ID - a number associated with your WUT email
    - TF_VAR_billing_account - billing account ID (GCP Console > Billing > Billing account ID)
3. Open the notebook `01_ds_lab_project_bootstrap.ipynb` on Colab by clicking the badge below
* Bootstrap GCP project [![Open in Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/biodatageeks/ds-lab-infra/blob/master/notebooks/01_ds_lab_project_bootstrap.ipynb)
4. Run the notebook `02_ds_lab_infra_setup.ipynb` on Colab by clicking the badge
* Provision Big Data Lab resources [![Open in Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/biodatageeks/ds-lab-infra/blob/master/notebooks/02_ds_lab_infra_setup.ipynb)
5. Change parameter in `notebooks/01_ds_lab_project_bootstrap.ipynb` and `notebooks/02_ds_lab_infra_setup.ipynb`:
    - USER_NAME - set to your GitHub username
6. Run both Colab notebooks.
7. Go to GCP Console > Dataproc > Workbench > Open JupyterLab.
8. Authenticate to GitHub:
    - Open terminal in JupyterLab
    - Run the following commands:
    ```
    apt-get update
    apt-get install gh
    gh auth login
    ```
    - Select options: GitHub.com > HTTPS > Y > Login with web browser > Enter > Open webpage `https://github.com/login/device` in a new tab > Login to GitHub > Continue > Copy code from terminal > Paste code in GitHub > Authorize > Return to terminal > Enter.
    - You should see the following message:
    ```
    ✓ Authentication complete. Press Enter to continue...

    gh config set -h github.com git_protocol https
    ✓ Configured git protocol
    ✓ Logged in as <your_username>
    ```
9. Fork the repo `https://github.com/biodatageeks/ds-notebooks.git`
10. Clone the repo:
```
cd
USER_NAME=<your_github_username>
git clone https://github.com/$USER_NAME/ds-notebooks.git
```
11. Run the `/root/ds-notebooks/session_1/` notebooks (on `LocalDisk` mount, not on `GCS` mount). (Kernel: Python 3)
