from django.urls import path
from rest_framework.urlpatterns import format_suffix_patterns
from eval_podemos import views


app_name = 'eval_podemos'
urlpatterns = [
    path('', views.IndexView.as_view(), name='index'),
    path('grupos/', views.GruposView.as_view(), name='grupos'),
    path('grupos/<str:pk>/', views.GruposDetailView.as_view(), name='detalle_grupo'),
    path('grupos/<str:grupo_id>/miembros', views.miembros_grupo, name='miembros_grupo'),
    path('grupos/<str:grupo_id>/cuentas', views.cuentas_grupo, name='cuentas_grupo'),
    path('clientes/', views.ClientesView.as_view(), name='clientes'),
    path('clientes/<str:pk>/', views.ClientesDetailView.as_view(), name='detalle_cliente'),
    path('cuentas/', views.CuentasView.as_view(), name='cuentas'),
    path('cuentas/<str:pk>/', views.CuentasDetailView.as_view(), name='detalle_cuenta'),
]

urlpatterns = format_suffix_patterns(urlpatterns)