# coding: utf-8
from sqlalchemy import Boolean
from sqlalchemy import Column, Enum, DATE, DECIMAL, INTEGER
from sqlalchemy.ext.declarative import declarative_base


Base = declarative_base()
metadata = Base.metadata


class Participant(Base):
    __tablename__ = 'participant'

    id = Column(INTEGER, primary_key=True, autoincrement=False)
    gender = Column(Enum('M', 'F', 'O', name='gender'))
    birth_date = Column(DATE)
    age = Column(DECIMAL)
