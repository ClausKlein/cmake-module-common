from conans import ConanFile
from conans.tools import download, unzip
import os

VERSION = "0.0.10"


class CMakeModuleCommonConan(ConanFile):
    name = "cmake-module-common"
    version = os.environ.get("CONAN_VERSION_OVERRIDE", VERSION)
    generators = "cmake"
    url = "http://github.com/polysquare/cmake-module-common"
    license = "MIT"
    requires = ("cmake-unit/master@smspillaz/cmake-unit",
                "cmake-linter-cmake/master@smspillaz/cmake-linter-cmake",
                "style-linter-cmake/master@smspillaz/style-linter-cmake")
    options = {
        "dev": [True, False]
    }
    default_options = "dev=False"

    def source(self):
        zip_name = "cmake-module-common.zip"
        download("https://github.com/polysquare/"
                 "cmake-module-common/archive/{version}.zip"
                 "".format(version="v" + VERSION),
                 zip_name)
        unzip(zip_name)
        os.unlink(zip_name)

    def package(self):
        self.copy(pattern="Find*.cmake",
                  dst="",
                  src="cmake-module-common-" + VERSION,
                  keep_path=True)
        self.copy(pattern="*.cmake",
                  dst="cmake/cmake-module-common",
                  src="cmake-module-common-" + VERSION,
                  keep_path=True)
