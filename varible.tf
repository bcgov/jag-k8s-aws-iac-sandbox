variable "node_group_name"{
    type = string
    description = "This variabele defines name of the node-group"
    default = ""
}

variable "eks_node_role"{
    type = string
    description = "This variabele defines name of the node-role"
    default = ""
}

variable "eks_cluster_role"{
    type = string
    description = "This variabele defines name of the cluster-role"
    default = ""
}

variable "eks_cluster"{
    type = string
    description = "This variabele defineseks cluster name"
    default = ""
}

variable "cidr_block"{
    description = "This variabele defines cidr_block"
    default = [""]
}


data "aws_availability_zones" "available" {}