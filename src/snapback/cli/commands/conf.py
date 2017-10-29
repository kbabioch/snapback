import logging
from snapback.config import Config

logger = logging.getLogger()

def conf_list(args):

    logger.debug('list configurations: ' + str(args))

    for config in Config.get_available_configs():

        print(config)


def conf_create(args):

    logger.debug('create configuration: ' + str(args))

    Config(args.config)


def conf_delete(args):

    logger.debug('delete configuration: ' + str(args))

    Config.delete_config_file(args.config)


def conf_edit(args):

    logger.debug('edit configuration: ' + str(args))

    pass
    # TODO

