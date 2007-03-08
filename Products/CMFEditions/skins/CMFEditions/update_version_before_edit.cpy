## Script (Python) "update_version_on_edit"
##title=Edit Content
##bind container=container
##bind context=context
##bind namespace=
##bind script=script
##bind subpath=traverse_subpath
##parameters=
##

REQUEST = context.REQUEST
pr = context.portal_repository
isVersionable = pr.isVersionable(context)
comment = "Initial revision"

version_id = getattr(context, "version_id", None)
changed = False
if version_id is None:
    changed = True
else:
    changed = not pr.isUpToDate(context, version_id)
if not changed:
    return state.set(status='success')

if comment is not None and \
         pr.supportsPolicy(context, 'at_edit_autoversion') and isVersionable:
    context.portal_repository.save(obj=context, comment=comment)

return state.set(status='success')