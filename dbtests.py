import mysql.connector
import pytest
from datetime import datetime, timedelta
import time

def get_db_connection():
    """Create and return a connection to the MySQL database"""
    return mysql.connector.connect(
        host="localhost",
        user="root",
        password="mysql@123",
        database="subscribers_db"
    )

def test_subscribers_table_exists():
    """Test if the subscribers table exists in the database"""
    conn = get_db_connection()
    cursor = conn.cursor()
    
    cursor.execute("SHOW TABLES LIKE 'subscribers'")
    assert cursor.fetchone() is not None, "Subscribers table does not exist"
    
    cursor.close()
    conn.close()

def test_table_structure():
    """Test if the subscribers table has the required structure"""
    conn = get_db_connection()
    cursor = conn.cursor()
    
    # Check the columns in the subscribers table
    cursor.execute("SHOW COLUMNS FROM subscribers")
    columns = {column[0] for column in cursor.fetchall()}
    
    required_columns = {'id', 'email', 'subscription_date'}
    assert required_columns.issubset(columns), f"Missing required columns. Found: {columns}"
    
    # Check if id is primary key and auto-increment
    cursor.execute("SHOW COLUMNS FROM subscribers LIKE 'id'")
    id_column = cursor.fetchone()
    assert id_column is not None, "ID column not found"
    assert "auto_increment" in id_column[5].lower(), "ID column is not auto-increment"
    assert "pri" in id_column[3].lower(), "ID column is not a primary key"
    
    # Check if email is unique
    cursor.execute("SHOW COLUMNS FROM subscribers LIKE 'email'")
    email_column = cursor.fetchone()
    assert email_column is not None, "Email column not found"
    
    cursor.execute("SHOW INDEX FROM subscribers WHERE Column_name = 'email' AND Non_unique = 0")
    assert cursor.fetchone() is not None, "Email column is not unique"
    
    cursor.close()
    conn.close()

def test_subscription_date_auto_population():
    """Test if subscription_date is automatically populated with current timestamp"""
    conn = get_db_connection()
    cursor = conn.cursor()
    
    # Test timestamp
    test_email = f'test_{int(time.time())}@example.com'
    cursor.execute(f"INSERT INTO subscribers (email) VALUES ('{test_email}')")
    conn.commit()
    
    cursor.execute(f"SELECT subscription_date FROM subscribers WHERE email = '{test_email}'")
    result = cursor.fetchone()
    assert result is not None, "No subscription date found"
    assert result[0] is not None, "Subscription date was not automatically populated"
    
    # Check if subscription_date is close to current time
    subscription_time = result[0]
    current_time = datetime.now()
    
    # Convert subscription_time to datetime if it's not already
    if not isinstance(subscription_time, datetime):
        if isinstance(subscription_time, str):
            subscription_time = datetime.strptime(subscription_time, '%Y-%m-%d %H:%M:%S')
    
    # Allow for small time differences (2 minutes max)
    time_diff = abs((current_time - subscription_time).total_seconds())
    assert time_diff < 120, f"Subscription date is not current timestamp. Difference: {time_diff} seconds"
    
    # Cleanup
    cursor.execute(f"DELETE FROM subscribers WHERE email = '{test_email}'")
    conn.commit()
    
    cursor.close()
    conn.close()

def test_multiple_subscribers():
    """Test adding multiple subscribers and verifying their data"""
    conn = get_db_connection()
    cursor = conn.cursor()
    
    # Add multiple test subscribers
    timestamp = int(time.time())
    test_emails = [f'test_{timestamp}_1@example.com', f'test_{timestamp}_2@example.com']
    
    for email in test_emails:
        cursor.execute(f"INSERT INTO subscribers (email) VALUES ('{email}')")
        conn.commit()
        time.sleep(1)  # Add a delay to ensure different timestamps
    
    # Verify all test subscribers were added
    cursor.execute(f"SELECT email, subscription_date FROM subscribers WHERE email LIKE 'test_{timestamp}%'")
    results = cursor.fetchall()
    assert len(results) == 2, f"Expected 2 test subscribers, found {len(results)}"
    
    # Verify subscription dates are different
    dates = [result[1] for result in results]
    assert dates[0] != dates[1], "Subscription dates should be different for different inserts"
    
    # Cleanup
    for email in test_emails:
        cursor.execute(f"DELETE FROM subscribers WHERE email = '{email}'")
    conn.commit()
    
    cursor.close()
    conn.close()

if __name__ == "__main__":
    pytest.main([__file__]) 