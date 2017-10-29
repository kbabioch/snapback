import logging

logger = logging.getLogger()

def snap_create(args):
    logger.debug('create snapshot: ' + str(args))

def snap_list(args):
    logger.debug('list snapshot(s): ' + str(args))

def snap_delete(args):
    logger.debug('delete snapshot: ' + str(args))

