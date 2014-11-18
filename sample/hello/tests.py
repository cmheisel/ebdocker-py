from django.template import Template, Context


def test_get_setting_as_variable(settings):
    settings.GREETING = "Hola"
    template = Template(
        r'{% load config %}{% get_setting "GREETING" as greeting %}{{ greeting }}'
    )
    c = Context({})
    assert template.render(c) == "Hola"
