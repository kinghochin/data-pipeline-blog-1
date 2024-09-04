from datetime import datetime
from airflow import DAG
from airflow.operators.python import PythonOperator
from redis_hook import RedisHook

default_args = {
    'owner': 'airflow',
    'depends_on_past': False,
    'start_date': datetime(2024, 8, 20),
    'retries': 1,
}

def push_to_redis():
    redis_hook = RedisHook(redis_conn_id='redis_default')
    redis_hook.set('DataKey', 'Data to Load...')
    print("Pushed to Redis: my_key -> my_value")

def pull_from_redis():
    redis_hook = RedisHook(redis_conn_id='redis_default')
    value = redis_hook.get('DataKey')
    print(f"Pulled from Redis: DataKey -> {value}")

dag = DAG(
    'redis_example_dag',
    default_args=default_args,
    description='A simple tutorial DAG using Redis',
    schedule_interval=None,
)

push_task = PythonOperator(
    task_id='push_to_redis',
    python_callable=push_to_redis,
    dag=dag,
)

pull_task = PythonOperator(
    task_id='pull_from_redis',
    python_callable=pull_from_redis,
    dag=dag,
)

push_task >> pull_task
