# TODO logging
import os
from os import path

class Config:

    CONFDIR='conf/' # TODO Put this in some more useful place


    # TODO Is this neccessary? Try to create object, see if it fails?
    @staticmethod
    def is_config_existing(name): 

        return os.path.isfile(Config.CONFDIR + name)


    @staticmethod
    def get_config_file(name):

        return CONFDIR + name


    @staticmethod
    def get_available_configs():

        return [f for f in os.listdir(Config.CONFDIR) if path.isfile(Config.CONFDIR + f)]


    @staticmethod
    def delete_config_file(name):

        # TODO Check whether file exists?
        # TODO Permissions?
        # TODO What if there is still an object referencing this object?
        os.remove(Config.CONFDIR + name)


    def __init__(self, name = None):

        if not self.is_config_existing(name):

            open(self.CONFDIR + name, 'w')

        else:

            raise ValueError('Config is already existing')

