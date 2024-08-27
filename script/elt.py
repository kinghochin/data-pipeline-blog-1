import subprocess
import time

def wait_for_postgres(host, max=10, delay=10):
    """PostgreSQL Starting..."""
    retries = 0
    while retries < max:
        try:
            result = subprocess.run(
                ["pg_isready", "-h", host], check=True, capture_output=True, text=True)
            if "accepting connections" in result.stdout:
                print("PostgreSQL Connected!")
                return True
        except subprocess.CalledProcessError as e:
            print(f"Error: {e}")
            retries += 1
            print(
                f"Retrying in {delay} seconds... (Attempt {retries}/{max})")
            time.sleep(delay)
    print("Retry but still failed.")
    return False

if not wait_for_postgres(host="source_db"):
    exit(1)

source_config = {
    'dbname': 'source_db',
    'user': 'postgres',
    'password': 'secret',
    'host': 'source_db'
}

destination_config = {
    'dbname': 'destination_db',
    'user': 'postgres',
    'password': 'secret',
    'host': 'destination_db'
}

dump_command = [
    'pg_dump',
    '-h', source_config['host'],
    '-U', source_config['user'],
    '-d', source_config['dbname'],
    '-f', 'data_dump.sql',
    '-w'
]

subprocess_env = dict(PGPASSWORD=source_config['password'])

subprocess.run(dump_command, env=subprocess_env, check=True)

load_command = [
    'psql',
    '-h', destination_config['host'],
    '-U', destination_config['user'],
    '-d', destination_config['dbname'],
    '-a', '-f', 'data_dump.sql'
]

subprocess_env = dict(PGPASSWORD=destination_config['password'])

subprocess.run(load_command, env=subprocess_env, check=True)

print("End ELT by Python script.")