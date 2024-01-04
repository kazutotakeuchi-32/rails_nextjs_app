/* 
  public_aのroute tableを作成
  -----------------------------
  0.0.0.0./0 to internet gateway
  100.0.0.0/16 to local
  -----------------------------
 */

resource "aws_route_table" "public_a" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = {
    Name = "${var.public_subnet_a["name"]}-rt"
  }
}

resource "aws_route_table_association" "public_a" {
  route_table_id      = aws_route_table.public_a.id
  subnet_id  = aws_subnet.public_subnet_a.id
}

/* 
  public_cのroute tableを作成
  -----------------------------
  0.0.0.0./0 to internet gateway
  100.0.0.0/16 to local
  -----------------------------
 */

resource "aws_route_table" "public_c" {
  vpc_id = aws_vpc.this.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = {
    Name = "${var.public_subnet_c["name"]}-rt"
  }
}

resource "aws_route_table_association" "public_c" {
  route_table_id     = aws_route_table.public_c.id
  subnet_id  = aws_subnet.public_subnet_c.id
}

/* 
  private_aのroute tableを作成
  -----------------------------
  100.0.0.0/16 to local
  -----------------------------
*/

resource "aws_route_table" "private_a" {
  vpc_id = aws_vpc.this.id
  tags = {
    Name = "${var.private_subnet_a["name"]}-rt"
  }
}

resource "aws_route_table_association" "private_a" {
  route_table_id     = aws_route_table.private_a.id
  subnet_id = aws_subnet.private_subnet_a.id
}

/* 
  private_cのroute tableを作成
  -----------------------------
  100.0.0.0/16 to local
  -----------------------------
 */
resource "aws_route_table" "private_c" {
  vpc_id = aws_vpc.this.id
  tags = {
    Name = "${var.private_subnet_c["name"]}-rt"
  }
}

resource "aws_route_table_association" "private_c" {
  route_table_id      = aws_route_table.private_c.id
  subnet_id = aws_subnet.private_subnet_c.id
}



