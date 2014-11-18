from django import template

register = template.Library()


@register.assignment_tag
def get_setting(key):
    from django.conf import settings
    return settings.__getattr__(key)
