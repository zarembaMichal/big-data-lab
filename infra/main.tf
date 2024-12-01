locals {
  main_subnet_address  = "10.10.10.0/24"
  project_vpc_name     = "main-vpc"
  dataproc_subnet_name = "dataproc-01"
  dataproc_subnet_id   = "${var.region}/${local.dataproc_subnet_name}"
}

module "vpc" {
  source         = "./modules/vpc"
  project_name   = var.project_name
  region         = var.region
  network_name   = local.project_vpc_name
  subnet_name    = local.dataproc_subnet_name
  subnet_address = local.main_subnet_address
}

module "dataproc" {
  depends_on   = [module.vpc]
  source       = "./modules/dataproc"
  project_name = var.project_name
  region       = var.region
  subnet       = module.vpc.subnets[local.dataproc_subnet_id].id
  machine_type = "e2-standard-2"
}