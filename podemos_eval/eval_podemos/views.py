from django.shortcuts import render
from django.views import generic
from .models import Clientes, Grupos, Miembros, Cuentas


class IndexView(generic.ListView):
    template_name = 'eval_podemos/index.html'
    context_object_name = 'grupos'

    def get_queryset(self):
        return Grupos.objects.all()

class GruposView(generic.ListView):
    template_name = 'eval_podemos/grupos.html'
    context_object_name = 'grupos'
    context = {"Grupos": "active"}

    def get_queryset(self):
        return Grupos.objects.all()

class GruposDetailView(generic.DetailView):
    template_name = 'eval_podemos/detalleGrupo.html'
    context_object_name = 'grupos'

    def get_queryset(self):
        return Grupos.objects.all()

class ClientesView(generic.ListView):
    template_name = 'eval_podemos/clientes.html'
    context_object_name = 'clientes'

    def get_queryset(self):
        return Clientes.objects.all()

class ClientesDetailView(generic.DetailView):
    template_name = 'eval_podemos/detalleCliente.html'
    context_object_name = 'clientes'

    def get_queryset(self):
        return Clientes.objects.all()

class CuentasView(generic.ListView):
    template_name = 'eval_podemos/cuentas.html'
    context_object_name = 'cuentas'

    def get_queryset(self):
        return Cuentas.objects.all()

class CuentasDetailView(generic.DetailView):
    template_name = 'eval_podemos/detalleCuenta.html'
    context_object_name = 'cuentas'

    def get_queryset(self):
        return Cuentas.objects.all()

def miembros_grupo(request, grupo_id):
    grupos = Grupos.objects.all()
    clientes = Clientes.objects.all()
    miembros = Miembros.objects.all()
    groups = []
    members = []
    team = {}

    datos = {'miembros': miembros, 'clientes': clientes, 'groups': groups}
    miembros_grupo = get_nombres_miembros(datos)
    data = {
        'miembros_grupo': miembros_grupo,
        'grupos': grupos,
        'members': members,
        'grupo_id': grupo_id
    }
    data_grupo = get_data_grupo(data)
    team['nombre'] = data_grupo['nombre_grupo']
    team['info'] = members
    return render(request, 'eval_podemos/miembrosGrupo.html', {'grupo': team})

def get_nombres_miembros(data):
    for cliente in data['clientes']:
        client = cliente.__dict__
        for miembro in data['miembros']:
            member = miembro.__dict__
            if member['cliente_id'] == client['id']:
                member['nombre'] = client['nombre']
                data['groups'].append(member)

    return data['groups']

def get_data_grupo(data):
    for miembro in data['miembros_grupo']:
        for grupo in data['grupos']:
            group = grupo.__dict__
            if data['grupo_id'] == miembro['grupo_id'] and data['grupo_id'] == group['id'] :
                data['members'].append(miembro)
                nombre_grupo = group['nombre']

    datos = {'members': data['members'], 'nombre_grupo': nombre_grupo}
    return datos

def cuentas_grupo(request, grupo_id):
    cuentas = Cuentas.objects.all()
    grupos = Grupos.objects.all()
    cuentas_grupo = []
    cuenta_info = {}

    for cuenta in cuentas:
        id_grupo = cuenta.__dict__['grupo_id']
        info_cuenta = cuenta.__dict__
        if grupo_id == id_grupo:
            cuentas_grupo.append(info_cuenta)

    for grupo in grupos:
        id_grupo = grupo.__dict__['id']
        info_grupo = grupo.__dict__
        if grupo_id == id_grupo:
            cuenta_info['nombre_grupo'] = info_grupo['nombre']

    cuenta_info['info'] = cuentas_grupo
    return render(request, 'eval_podemos/cuentasGrupo.html', {'grupo': cuenta_info})