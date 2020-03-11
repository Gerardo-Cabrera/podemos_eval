from django.db import models


class Clientes(models.Model):
    id = models.CharField(primary_key=True, max_length=7)
    nombre = models.CharField(max_length=60)

    class Meta:
        managed = False
        db_table = 'Clientes'


class Grupos(models.Model):
    id = models.CharField(primary_key=True, max_length=5)
    nombre = models.CharField(max_length=20)

    class Meta:
        managed = False
        db_table = 'Grupos'


class Miembros(models.Model):
    grupo = models.OneToOneField(Grupos, models.DO_NOTHING, primary_key=True)
    cliente = models.ForeignKey(Clientes,  models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'Miembros'
        unique_together = (('grupo', 'cliente'),)


class Cuentas(models.Model):
    id = models.CharField(primary_key=True, max_length=5)
    grupo = models.ForeignKey(Grupos, models.DO_NOTHING)
    estatus = models.CharField(max_length=15)
    monto = models.DecimalField(max_digits=15, decimal_places=2)
    saldo = models.DecimalField(max_digits=15, decimal_places=2)

    class Meta:
        managed = False
        db_table = 'Cuentas'


class Calendariopagos(models.Model):
    id = models.IntegerField(primary_key=True)
    cuenta = models.ForeignKey(Cuentas, models.DO_NOTHING)
    num_pago = models.IntegerField()
    monto = models.DecimalField(max_digits=15, decimal_places=2)
    fecha_pago = models.DateField()
    estatus = models.CharField(max_length=15)

    class Meta:
        managed = False
        db_table = 'CalendarioPagos'


class Transacciones(models.Model):
    id = models.IntegerField(primary_key=True)
    cuenta = models.ForeignKey(Cuentas, models.DO_NOTHING)
    fecha = models.DateTimeField()
    monto = models.DecimalField(max_digits=15, decimal_places=2)

    class Meta:
        managed = False
        db_table = 'Transacciones'
