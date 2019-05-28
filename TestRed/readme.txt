Python 3.7+ req

run cmd as admin to install below commands
python -m pip install --upgrade pip
python -m pip install robotframework
python -m pip install webdrivermanager
python -m pip install --upgrade robotframework-seleniumlibrary


to run test in parallel
open command as admin and run parallel.bat script
or run this
{
start "" robot -v browser:firefox -d firefox/ -T -s TestSuite .
start "" robot -v browser:chrome -d chrome/ -T -s TestSuite .
}

==========
log's/report can be find in chrome/firefox dir
