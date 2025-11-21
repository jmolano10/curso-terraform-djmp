resource "local_file" "productos" {
  count    = 4
  content  = "Lista de productos para el mes proximo"
  filename = "productos-${random_string.sufijo[count.index].id}.txt"
}

resource "random_string" "sufijo" {
  count   = 4
  length  = 4
  special = false
  upper   = false
  numeric = false
}




