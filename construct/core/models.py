from django.db import models
from django.utils.translation import gettext_lazy as _

class Entry(models.Model):
	name = models.CharField(max_length=70, verbose_name=_(u'Name'))

	def __str__(self):
			return self.name

	class Meta:
		ordering = ['name']
		verbose_name = _(u'Entry')
		verbose_name_plural = _(u'Entries')
