from django.conf.urls import patterns, include, url

from hello.views import DebugView, HomePageView

urlpatterns = patterns('',
    # Examples:
    # url(r'^$', 'sample.views.home', name='home'),
    # url(r'^blog/', include('blog.urls')),

    url(r'^$', HomePageView.as_view(), name='index'),
    url(r'^debug/$', DebugView.as_view(), name="debug"),
)
