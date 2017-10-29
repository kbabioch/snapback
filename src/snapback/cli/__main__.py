"""Command line interface (CLI) for snapback"""

import argparse
import logging
import snapback.cli.commands
from snapback._version import __version__

# TODO Incorporate into code?
logger = logging.getLogger()
logging.basicConfig(level=logging.DEBUG)

# TODO help subcommand

# TODO Re-structure
# create_parser
# create subparser for command, e.g. create_command('snap')
# create subparser for subcommand, e.g. create_command('snap', 'list')?
# include common options, etc.
def create_command(command):
    pass

def create_subcommand(command, subcommand):
    pass


def main():

    # TODO: only when in verbose mode?
    # logging.basicConfig(level=logging.INFO)
    # TODO enable logging

    # main parser
    parser = argparse.ArgumentParser()
    parser.add_argument('-V', '--version', action='version', version='%(prog)s ' + __version__)

    # parent parser (common options)
    parentparser = argparse.ArgumentParser(add_help=False)
    parentparser.add_argument('-v', '--verbose', action='store_true')

    # Command parser
    commandparser = parser.add_subparsers(dest='command', help='Command')
    commandparser.required = True

    # snap parser
    snapparser = commandparser.add_parser('snap')
    subparser = snapparser.add_subparsers(dest='subcommand', help='Subcommand')
    subparser.required = True

    createparser = subparser.add_parser('create', parents=[parentparser])
    createparser.set_defaults(func=snapback.cli.commands.snap_create)

    listparser = subparser.add_parser('list', parents=[parentparser])
    listparser.set_defaults(func=snapback.cli.commands.snap_list)

    deleteparser = subparser.add_parser('delete', parents=[parentparser])
    deleteparser.set_defaults(func=snapback.cli.commands.snap_delete)

    # back parser
    backparser = commandparser.add_parser('back')
    subparser = backparser.add_subparsers(dest='subcommand', help='Subcommand')
    subparser.required = True

    backparentparser = argparse.ArgumentParser(add_help=False)
    backparentparser.add_argument('config', metavar='CONFIG', help='Name of configuration', nargs='?')

    statusparser = subparser.add_parser('status', parents=[parentparser, backparentparser])
    statusparser.set_defaults(func=snapback.cli.commands.back_status)

    pauseparser = subparser.add_parser('pause', parents=[parentparser, backparentparser])
    pauseparser.set_defaults(func=snapback.cli.commands.back_pause)

    resumeparser = subparser.add_parser('resume', parents=[parentparser, backparentparser])
    resumeparser.set_defaults(func=snapback.cli.commands.back_resume)

    # conf parser
    confparser = commandparser.add_parser('conf')
    subparser = confparser.add_subparsers(dest='subcommand', help='Subcommand')
    subparser.required = True

    listparser = subparser.add_parser('list', parents=[parentparser])
    listparser.set_defaults(func=snapback.cli.commands.conf_list)

    confparentparser = argparse.ArgumentParser(add_help=False)
    confparentparser.add_argument('config', metavar='CONFIG', help='Name of configuration')

    createparser = subparser.add_parser('edit', parents=[parentparser, confparentparser])
    createparser.set_defaults(func=snapback.cli.commands.conf_edit)

    createparser = subparser.add_parser('create', parents=[parentparser, confparentparser])
    createparser.set_defaults(func=snapback.cli.commands.conf_create)

    deleteparser = subparser.add_parser('delete', parents=[parentparser, confparentparser])
    deleteparser.set_defaults(func=snapback.cli.commands.conf_delete)

    # parse provided arguments
    args = parser.parse_args()

    try:

        args.func(args)

    except AttributeError:

        pass


if __name__ == '__main__':

    main()

