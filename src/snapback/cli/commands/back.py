import logging

logger = logging.getLogger()

def back_status(args):
    logger.debug('backup status: ' + str(args))

def back_pause(args):
    logger.debug('pause backup(s) ' + str(args))

def back_resume(args):
    logger.debug('resume backup(s) ' + str(args))

