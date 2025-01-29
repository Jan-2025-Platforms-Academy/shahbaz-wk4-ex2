resource "aws_db_subnet_group" "this" {
  name = "db_subnet_group"
  subnet_ids = [ aws_subnet.private_subnet_2.id, aws_subnet.private_subnet_4.id, aws_subnet.private_subnet_5.id ]

    tags = {
        Name = "Shahbaz-DB Subnet group"
    }
}

resource "aws_db_instance" "this" {
  allocated_storage = 20
  engine = "mariadb"
  instance_class = "db.t2.micro"
  db_name = "sample"
  username = "admin"
  password = "1Password1"
  db_subnet_group_name = aws_db_subnet_group.this.name
  vpc_security_group_ids = [ aws_security_group.db-sg.id ]

  multi_az = true
  storage_type = "gp2"
  publicly_accessible = false

  tags = {
    Name = "Maria DB rds instance"
  }
}