from django.views.generic.base import TemplateView

import logging
logger = logging.getLogger("hello.views")


# Create your views here.
class HomePageView(TemplateView):
    template_name = "hello/index.html"

    def get_context_data(self, **kwargs):
        context = super(HomePageView, self).get_context_data(**kwargs)

        return context


class DebugView(TemplateView):
    template_name = "hello/debug.html"

    def get_context_data(self, **kwargs):
        context = super(DebugView, self).get_context_data(**kwargs)
        context['META'] = self.request.META
        try:
            context['HTTP_HOST'] = self.request.get_host()
        except KeyError:
            context['HTTP_HOST'] = "unavailable"
        return context
