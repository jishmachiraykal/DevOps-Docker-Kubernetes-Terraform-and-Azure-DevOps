* Terraform variables commands:
    terraform console
        > var.names
        tolist([
          "Ava",
          "Serah",
          "Mirah",
        ])

        > var.names[0]
        "Ava"
        > var.names[1]
        "Serah"
        > var.names[2]
        "Mirah"

        > length(var.names)
        3

        > reverse(var.names)
        tolist([
          "Mirah",
          "Serah",
          "Ava",
        ])

        > distinct(var.names)
        tolist([
          "Ava",
          "Serah",
          "Mirah",
        ])

        > contains(var.names,"Ava")
        true
        > contains(var.names,"Hannah")
        false
        > range(10)
        tolist([
          0,
          1,
          2,
          3,
          4,
          5,
          6,
          7,
          8,
          9,
        ])

        > range(1,12)
        tolist([
          1,
          2,
          3,
          4,
          5,
          6,
          7,
          8,
          9,
          10,
          11,
        ])

        > range(1,12,4)
        tolist([
          1,
          5,
          9,git log
        ])
>

* More functions can be found in https://developer.hashicorp.com/terraform/language/functions/

* If we use count, deletion and update of variables will be based on index and if we use for each deletion and update will be based on variable value(Serah/Hannah) itself

