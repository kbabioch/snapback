from setuptools import setup, find_packages

# Get version from module
exec(open('src/snapback/_version.py').read())

setup(
    name = 'snapback',
    version = __version__,
    url = 'https://github.com/kbabioch/snapback',
    author = 'Karol Babioch',
    author_email = 'karol@babioch.de',
    description = 'snapback', # TODO
    license = 'GPL3+',

    packages = find_packages(where='src'),
    package_dir = {'': 'src'},

    entry_points={
        'console_scripts': [
            'snapback = snapback.cli.__main__:main',
        ]
    },
)

