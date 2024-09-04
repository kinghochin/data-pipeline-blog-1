from airflow.hooks.base_hook import BaseHook
import redis

class RedisHook(BaseHook):
    """
    Interact with Redis.
    """

    def __init__(self, redis_conn_id='redis_default'):
        super().__init__()
        self.redis_conn_id = redis_conn_id
        self.redis_client = None

    def get_conn(self):
        """
        Returns a Redis connection object.
        """
        if self.redis_client is None:
            conn = self.get_connection(self.redis_conn_id)
            self.redis_client = redis.StrictRedis(
                host=conn.host,
                port=conn.port,
                password=conn.password,
                db=0,  # You can customize this depending on which DB you want to use
                decode_responses=True
            )
        return self.redis_client

    def set(self, key, value):
        """
        Set a key-value pair in Redis.
        """
        self.get_conn().set(key, value)

    def get(self, key):
        """
        Get a value by key from Redis.
        """
        return self.get_conn().get(key)
